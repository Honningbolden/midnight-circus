# canon_state.gd

extends StateMachineState

@export var player : Player
@export var canon: Node3D
@export var camera: Camera3D
@export var angle: float

var world : Node3D = null
var aim_speed : float = 0.005

func on_ready() -> void:
	world = player.get_parent()
	
func on_enter() -> void:
	player.velocity = Vector3.ZERO
	camera.look_at_position(Vector3(canon.global_position.x+100,canon.global_position.y,canon.global_position.z))
	player.position = Vector3(0, 1, 0)
	canon.ray.visible = true

func on_process(_delta: float) -> void:
	player.update_input()  # take the player's input

func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		change_state("Exploration State")
	elif event is InputEventMouseMotion:
		angle = event.relative.x * aim_speed
		canon.rotate_y(-angle)
	elif event.is_action_pressed("action"):  # if spacebar is pressed
		if canon.loaded:
			canon.fire()  # shoot the canonball
			canon.loaded = false

func on_exit() -> void:
	canon.rotation_degrees = Vector3(0, 0, 0)
	player.reparent(world)
	player.global_position = canon.global_position + Vector3(-1.5, 0, 0)
	player.rotation_degrees = Vector3(0,0,0)
	canon.ray.visible = false
	
