## canon_state.gd

extends StateMachineState


@export var player : Player
@export var aim_speed : float = 0.02
@export var canon: Interactable

var world : Node3D = null
var loaded = false

func on_ready() -> void:
	world = player.get_parent()
	
func on_enter() -> void:
	if loaded:
		player.position = Vector3.ZERO
	else:
		if GameManager.collected_items.has("Canonball"):
			GameManager.collected_items.erase("Canonball")
			loaded = true
		else:
			on_exit()

func on_process(_delta: float) -> void:
	player.update_input()  # take the player's input

func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		change_state("Exploration State")
	elif event.is_action_pressed("action"):  # if spacebar is pressed
		fire()  # shoot the canonball

func fire() -> void:
	loaded = false

func on_exit() -> void:
	player.reparent(world)
