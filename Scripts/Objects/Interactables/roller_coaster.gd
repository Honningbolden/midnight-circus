# roller_coaster.gd

extends Interactable

@export var Car : MeshInstance3D
@export var CoasterPath : PathFollow3D
@export var Area : Area3D
@export var player : Player
var maxSpeed = 5
var speed = 0
var acc = 0.1 # acceleration
var active = false
var started = false
var finished = false

func use(_player: Player) -> void:
	if active:
		if not started:
			started = true
			player = _player
			player.reparent(Car)
			var coaster_state = player.statemachine.get_node("Coaster State")
			coaster_state.Car = Car
			player.statemachine.change_state("Coaster State")
			await wait(1)
			Area.queue_free()
			# TASK: Make a sound effect for the ride turning on
		elif not finished:
			GameManager.collected_items.append("Coaster Fuse")
			finished = true
			await wait(3)
			player.statemachine.change_state("Exploration State")

func _physics_process(delta: float) -> void:
	if(finished):
		maxSpeed = 0
	elif(CoasterPath.progress_ratio >=1):
		CoasterPath.progress_ratio -= 1
		maxSpeed = 5
	if(CoasterPath.progress > 58):
		maxSpeed = 15
	update_speed(delta)
	CoasterPath.progress += delta * speed

func update_speed(_delta: float) -> void:
	if started:
		speed = move_toward(speed, maxSpeed, acc)
		if finished:
			speed = move_toward(speed, maxSpeed, 50 * acc)
	
func wait(seconds: float) -> void:        # Thanks to GBWD on the Godot forum
	await get_tree().create_timer(seconds).timeout
