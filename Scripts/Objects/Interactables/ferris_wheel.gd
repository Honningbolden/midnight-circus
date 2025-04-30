#ferris_wheel.gd

extends Interactable

@export var TipPoint: Node3D
@export var wheel: MeshInstance3D
@export var area: Area3D

func use(player: Player) -> void : 
	var areaPosition = area.global_position
	area.top_level = true
	area.global_position = areaPosition
	var tween = create_tween()
	tween.tween_property(self, "rotation", Vector3(0, 0, -PI/3), 5).set_trans(tween.TRANS_SINE).set_ease(tween.EASE_IN)
	tween.tween_property(TipPoint, "position", Vector3(TipPoint.position.x, TipPoint.position.y - 0.5, TipPoint.position.z), 0.2)
	await tween.finished
	
	var tween1 = create_tween()
	tween1.set_parallel(true)
	
	tween1.tween_property(TipPoint, "position", Vector3(TipPoint.position.x + 25, TipPoint.position.y, TipPoint.position.z), 25)
	tween1.tween_property(self, "rotation", Vector3(0, 0, -5 * PI/3), 25)
	await tween1.finished
	
	var tween2 = create_tween()
	tween2.tween_property(TipPoint, "rotation", Vector3(PI/2, 0, 0), 1.5)

	# TASK: Make a model
	# TASK: Make necessary sound effects
	# TASK: Make the Wheel trigger from the control box iff the player has the key
