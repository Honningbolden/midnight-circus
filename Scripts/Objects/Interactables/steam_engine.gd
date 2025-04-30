# steam_engine.gd

extends Interactable
@export var valve: MeshInstance3D


func use(_player: Player) -> void:
	if GameManager.collected_items.has("Steam Engine Valve"):
		GameManager.collected_items.erase("Steam Engine Valve")
		valve.visible = true
		var tween = create_tween()
		tween.tween_property(valve, "rotation_degrees", Vector3(0,90,0), 1)
