# steam_engine.gd

extends Interactable
@export var valve: MeshInstance3D


func use(_player: Player) -> void:
	$IdleSound.play()
	valve.visible = true
	var tween = create_tween()
	tween.tween_property(valve, "rotation_degrees", Vector3(90,0,0), 1)
	if GameManager.current_item == "Valve":
		GameManager.current_item = ""
		
