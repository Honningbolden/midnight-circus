# canon_state.gd

extends StateMachineState


@export var player : Player
@export var canon: Node3D
@export var camera: Camera3D
@export var angle: float

var world : Node3D = null
var loaded = true
var aim_speed : float = 0.005

func on_ready() -> void:
	world = player.get_parent()
	
func on_enter() -> void:
	player.velocity = Vector3.ZERO
	if loaded:
		player.position = Vector3(-0.5, -0.5, 0) # up/down, forward/backward, left/right
		canon.ray.visible = true
	else:
		if GameManager.current_item == "Canonball":
			GameManager.current_item = ""
			loaded = true
		else:
			change_state("Exploration State")

func on_process(_delta: float) -> void:
	player.update_input()  # take the player's input

func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		change_state("Exploration State")
	elif event is InputEventMouseMotion:
		angle = event.relative.x * aim_speed
		canon.rotate_y(-angle)
	elif event.is_action_pressed("action"):  # if spacebar is pressed
		if loaded == true:
			canon.fire()  # shoot the canonball
			loaded = false


func on_exit() -> void:
	canon.rotation_degrees = Vector3(0, 0, -90)
	player.reparent(world)
	player.global_position = canon.global_position + Vector3(-1.5, 0, 0)
	player.rotation_degrees = Vector3(0,0,90)
	canon.ray.visible = false
	
