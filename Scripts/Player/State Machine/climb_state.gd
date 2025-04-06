## climb_state.gd


extends StateMachineState


@export var player : Player
@export var camera : Camera3D

@export var climb_speed : float = 0.02

var world : Node3D = null
var ladder_pathfollow : PathFollow3D = null


func on_ready() -> void:
	world = player.get_parent()


func on_enter() -> void:
	player.position = Vector3.ZERO
	var ladder = ladder_pathfollow.get_parent().get_parent()
	print(ladder.global_position, player.global_position)
	camera.look_at_position(ladder.global_position)


func on_process(_delta: float) -> void:
	player.update_input()  # take the player's input


func on_physics_process(_delta: float) -> void:
	climb_ladder()


func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		change_state("Exploration State")
	elif event is InputEventMouseMotion:  # if mouse moved
		camera.update_camera_input(event.relative)  # update the camera
	elif event is InputEventJoypadMotion:  # if joystick moved
		camera.update_camera_input(camera.get_joy_direction())


func climb_ladder() -> void:
	var direction = player.vertical_direction
	ladder_pathfollow.progress += climb_speed * direction


func on_exit() -> void:
	ladder_pathfollow = null
	player.reparent(world)
