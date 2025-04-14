# fence.gd

extends Interactable
@export var container : Node3D

func use(_player: Player) -> void:
	for node in self.get_children():
		var tween = create_tween()
		tween.tween_property(self, "rotation", Vector3(0, 0, -PI/2), 1)
		
	# TASK: Make models for the fence
	# TASK: Make sound effect
	# TASK: Make the ferris wheel interract with the fence instead of the player
