## tightrope_state.gd


extends StateMachineState


@export var player : Player
@export var camera : Camera3D

@export var climb_speed : float = 0.02

var world : Node3D = null
var rope_direction : float = 1.0
var tightrope_pathfollow : PathFollow3D = null


func on_enter() -> void:
	player.position = Vector3.UP
	player.velocity = Vector3.ZERO
	var tightrope = tightrope_pathfollow.get_parent().get_parent()
	camera.look_at_position(tightrope.global_position)


func on_process(_delta: float) -> void:
	player.update_input()  # take the player's input


func on_physics_process(_delta: float) -> void:
	walk_tightrope()


func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		change_state("Exploration State")
	elif event is InputEventMouseMotion:  # if mouse moved
		camera.update_camera_input(event.relative)  # update the camera
	elif event is InputEventJoypadMotion:  # if joystick moved
		camera.update_camera_input(camera.get_joy_direction())


func walk_tightrope() -> void:
	var direction = player.vertical_direction
	tightrope_pathfollow.progress += -climb_speed * direction * rope_direction


func on_exit() -> void:
	tightrope_pathfollow = null
