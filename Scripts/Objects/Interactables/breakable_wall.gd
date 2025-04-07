# breakable_wall.gd

extends Interactable
@export var container : Node3D

func use(_player: Player) -> void:
	for node in container.get_children():
		var path : Path3D = node.get_node("Path3D")
		var path_follow = path.get_node("PathFollow3D")
		var tween = create_tween()
		tween.tween_property(path_follow, "progress", path.curve.get_baked_length(), 1)
