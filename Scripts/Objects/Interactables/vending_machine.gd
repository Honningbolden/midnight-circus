# vending_machine.gd

extends Interactable


@export var gameworld : Node3D
@export var accept_player : AudioStreamPlayer3D
@export var deny_player : AudioStreamPlayer3D
@export var purchase_player : AudioStreamPlayer3D
@export var area : Area3D
@export var label : Label3D
@export var vodka_scene : PackedScene


func use(_player: Player) -> void:
	if GameManager.current_item == "Coin":
		GameManager.current_item = ""
		
		accept_player.play()
		await wait(0.25)
		purchase_player.play()
		await wait(1.5)
		
		var vodka = vodka_scene.instantiate()
		gameworld.add_child(vodka)
		vodka.global_position = self.global_position + Vector3(0, 0, 1)
		disable_interactable()
	else:
		deny_player.play()


func disable_interactable() -> void:
	area.queue_free()
	label.queue_free()


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
