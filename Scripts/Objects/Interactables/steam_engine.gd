# steam_engine.gd

extends Interactable
@export var valve: MeshInstance3D


func use(_player: Player) -> void:
	if GameManager.current_item == "Steam Engine Valve":
		GameManager.current_item = ""
		valve.visible = true
		var tween = create_tween()
		tween.tween_property(valve, "rotation_degrees", Vector3(0,90,0), 1)
