# circus_door.gd


extends Interactable

@export var Pivot1 : Node3D
@export var Pivot2 : Node3D


func use (player: Player) -> void:
	if GameManager.current_item == "Circus Key":
		GameManager.current_item = ""
		open_door()
		
		# TASK: Add an animation showing the door opening
		# TASK: Add a sound effect for the door opening
		
	else:
		pass
		# TASK: Add a sound effect for when the player doesn't have the key

func open_door():
	var tween1 = create_tween()
	var tween2 = create_tween()
	tween1.tween_property(Pivot1, "rotation", Vector3(0, PI/2, 0), 1)
	tween2.tween_property(Pivot2, "rotation", Vector3(0, -PI/2,0), 1)
