# vending_machine.gd

extends Interactable


@export var gameworld : Node3D
@export var accept_player : AudioStreamPlayer3D
@export var deny_player : AudioStreamPlayer3D
@export var vodka_scene : PackedScene


func use(_player: Player) -> void:
	if GameManager.current_item == "Coin":
		GameManager.current_item = ""
		
		accept_player.play()
		
		var vodka = vodka_scene.instantiate()
		gameworld.add_child(vodka)
		vodka.global_position = self.global_position + Vector3(0, 0, 1)
	else:
		deny_player.play()


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
