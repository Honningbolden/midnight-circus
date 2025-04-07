# breakable_wall.gd

extends Interactable
@export var container : Node3D

func use(_player: Player) -> void:
	for rock in container.get_children():
		var tween = create_tween()
		tween.tween_property(rock, "global_position", global_position + Vector3.LEFT*0.5, 1)
	
	await get_tree().create_timer(1.5).timeout
	for rock in container.get_children():
		rock.get_node("AnimatableBody3D").collision_layer=0
