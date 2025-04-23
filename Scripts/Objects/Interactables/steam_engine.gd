# steam_engine.gd

extends Interactable


func use(_player: Player) -> void:
	if GameManager.collected_items.has("Steam Engine Valve"):
		GameManager.collected_items.erase("Steam Engine Valve")
		$AnimationPlayer.play("rotate valve")
