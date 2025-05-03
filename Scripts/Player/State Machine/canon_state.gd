# canon_state.gd

extends StateMachineState

@export var player : Player
@export var canon: Node3D
@export var camera: Camera3D
@export var angle: float

var world : Node3D = null
var loaded = true
var aim_speed = 0.05


func _ready() -> void:
	world = player.get_parent()
	
func on_enter() -> void:
	player.velocity = Vector3.ZERO
	if loaded:
		player.position = Vector3(0, -0.5,0)
		player.forward_direction = 0.0
		camera.set_camera()
	else:
		if GameManager.collected_items.has("Canonball"):
			GameManager.collected_items.erase("Canonball")
			loaded = true
		else:
			change_state("Exploration State")

func on_process(_delta: float) -> void:
	player.update_input()  # take the player's input

func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		change_state("Exploration State")
	elif event is InputEventMouseMotion:  # if mouse moved
		angle = event.relative.x * aim_speed
		canon.rotate_y(-angle)
	elif event.is_action_pressed("action"):  # if spacebar is pressed
		fire()  # shoot the canonball

func fire() -> void:
	loaded = false

func on_exit() -> void:
	canon.rotation = Vector3(0,0,0)
	player.rotation = Vector3(0,0,0)
	player.position = Vector3(0,0,0)
	player.reparent(world)
	player.global_position = canon.global_position + Vector3(-2,0,0)
	canon.rotation_degrees = Vector3(0,0,-80)
	#player.forward_direction = 0.0
	#camera.setup_camera()
