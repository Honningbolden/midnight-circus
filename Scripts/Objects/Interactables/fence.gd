# fence.gd

extends Interactable
@export var container : Node3D

func use(_player: Player) -> void:
	#Task: make this work
	for node in self.get_children():
		var tween = create_tween()
		tween.tween_property(self, "rotation", Vector3(0, 0, -PI/2), 1)
