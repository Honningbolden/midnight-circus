extends Node2D

var pin_code = [1, 0, 1, 3, 2, 0, 0, 1]  #10/13/2001
var fix = ["start", "start"]; var dir = "start"
var rot = 0; var key = []; var code = []
@onready var dial = $Dial
@onready var turn_audio = $LockTurnAudio
@onready var inputted_code = $Inputs

@onready var input_delay: Timer = $Timer
var input_allowed = false
var puzzle_started = false

func initialize():
	for x in range(10):
		key.append(x)
	input_delay.timeout.connect(_on_input_cooldown_finished)
	input_delay.wait_time = 0.2
	input_delay.one_shot = true
	set_process_input(true)
	input_allowed = true

func _input(_event):
	if not input_allowed:
		return
		
	if Input.is_key_pressed(KEY_D):
		if dir == fix[0]:
			code.push_back(key[0])
			dir = "right"
			fix = ["left", "right"]
		key.push_back(key[0])
		key.pop_front()
		rot -= deg_to_rad(36)
		dial.rotation = rot
		turn_audio.play()
		start_input_cooldown()

	elif Input.is_key_pressed(KEY_A):
		if dir == fix[1]:
			code.push_back(key[0])
			dir = "left"
			fix = ["left", "right"]
		key.push_front(key[9])
		key.pop_back()
		rot += deg_to_rad(36)
		dial.rotation = rot
		turn_audio.play()
		start_input_cooldown()
		
	
	# Exit puzzle UI 
	if Input.is_key_pressed(KEY_Q):
		dial.rotation = 0
		rot = 0
		key = []
		code = []
		input_allowed = false
		get_parent().puzzle_end(false)
	
	# Pop if input size goes over the code size
	if code.size() > pin_code.size():
		code.pop_front()
			
	# Display code to user
	inputted_code.text = str(code)
	
	# If player gets the correct code
	if code == pin_code:
		inputted_code.add_theme_color_override("font_color", Color(0, 1, 0))
		await get_tree().create_timer(1).timeout
		get_parent().puzzle_end(true)
		# remove and end script
		queue_free()
		#get_node("safe").set_frame(1)
		#get_node("SamplePlayer").play("safe_open")
	

func start_input_cooldown():
	input_allowed = false
	input_delay.start()
	
	
func _on_input_cooldown_finished():
	input_allowed = true
