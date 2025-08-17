## tightrope_state.gd

extends StateMachineState


@export_category("Components")
@export var player : Player
@export var camera : Camera3D
@export var tightrope_timer : Timer

@export_category("Tightrope Constants")
@export var climb_speed : float = 0.01 # how fast you move along it
@export var sway_speed : float = 3.0 # how fast you rotate left and right
@export var sway_limit : float = 6.0 # how far you rotate
@export var balance_sensitivity : float = 20.0 # how quickly A and D adjusts tilt
@export var max_tilt_threshold : float = 20.0  # lean before fall in degrees

var tightrope : Node3D = null
var tightrope_pathfollow : PathFollow3D = null

var rope_direction : float = 1.0
var sway_angle : float = 0.0
var sway_direction : float = 1.0
var gust_active : bool = false
var gust_strength : float = 1.0
var last_sway_sign : int = 0
var current_tilt : float = 0.0  # player's tilt in degrees
var last_progress : float = 0.0


func on_enter() -> void:
	default_variables()
	tightrope_timer.start()
	camera.look_at_position(tightrope.global_position)


func default_variables() -> void:
	player.position = Vector3.UP
	player.velocity = Vector3.ZERO
	sway_angle = 0.0
	sway_direction = (randi_range(0, 1) * 2) - 1  # random direction [-1.0 or 1.0]
	gust_active = false
	gust_strength = 1.0
	last_sway_sign = 0
	current_tilt = 0.0
	last_progress = 0.0


func on_process(_delta: float) -> void:
	player.update_input()  # take the player's input


func on_physics_process(delta: float) -> void:
	walk_tightrope()
	update_sway(delta)
	update_balance(delta)
	apply_tilt()
	check_fall()
	check_progress()


func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		attempt_state_change("Exploration State")


func walk_tightrope() -> void:
	var direction = player.vertical_direction
	tightrope_pathfollow.progress += -climb_speed * direction * rope_direction


func update_sway(delta: float) -> void:
	sway_angle += sway_speed * delta
	if sway_angle > TAU:
		sway_angle -= TAU
	
	var current_sign = sign(sin(sway_angle))
	
	if current_sign != 0 and current_sign != last_sway_sign:
		last_sway_sign = current_sign
		
		if randi() % 3 == 0:
			gust_active = true
			gust_strength = randf_range(4.0, 7.5)
		else:
			gust_active = false


func update_balance(delta: float) -> void:
	var sway_base = sin(sway_angle) * sway_limit
	if gust_active:
		sway_base *= gust_strength
	
	# adjust tilt: sway pushes, player input counters
	current_tilt = move_toward(current_tilt, sway_base, 30.0 * delta)
	current_tilt = clamp(current_tilt, -45.0, 45.0)  # prevent absurd tilt
	
	var balance_input = player.horizontal_direction * balance_sensitivity * -rope_direction * delta
	current_tilt += balance_input


## Rotate the tightrope pathfollow
func apply_tilt() -> void:
	tightrope_pathfollow.rotation.z = deg_to_rad(current_tilt)


## Check if the player has leaned too much
func check_fall() -> void:
	if abs(current_tilt) > max_tilt_threshold:
		attempt_state_change("Exploration State")


## Check if the player has reached either end
func check_progress() -> void:
	if tightrope_pathfollow.progress_ratio != last_progress:
		if tightrope_pathfollow.progress_ratio in [0.0, 1.0]:
			attempt_state_change("Exploration State")
	if tightrope_pathfollow:
		last_progress = tightrope_pathfollow.progress_ratio


func attempt_state_change(state: String) -> void:
	if tightrope_timer.is_stopped():
		change_state(state)


func on_exit() -> void:
	tightrope.tightrope_finished()


func _on_tightrope_timer_timeout() -> void:
	pass # Replace with function body.
