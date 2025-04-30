extends StateMachineState
@export var Car : MeshInstance3D
@export var player : Player
@export var world : Node3D
@export var camera : Camera3D


func on_ready() -> void:
	world = player.get_parent()
	
	
func on_enter() -> void:
	player.can_move = false
	player.velocity = Vector3.ZERO
	player.position = Vector3.ZERO
	
func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:  # if mouse moved
		camera.update_camera_input(event.relative)  # update the camera
	elif event is InputEventJoypadMotion:  # if joystick moved
		camera.update_camera_input(camera.get_joy_direction())
	if event.is_action_pressed("interact"):
		player.interact()
		
		
func on_exit() -> void:
	player.can_move = true
	player.position.x += 1.5
	player.reparent(world)
