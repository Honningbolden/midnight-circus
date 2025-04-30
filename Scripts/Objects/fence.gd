# fence.gd

extends Node3D

func knock_over() -> void:
	for node in self.get_children():
		var tween = create_tween()
		tween.tween_property(self, "rotation", Vector3(0, 0, -PI/2), 1)
		

func _on_area_3d_area_entered(area: Area3D) -> void:
	self.knock_over()

	# TASK: Make models for the fence
	# TASK: Make sound effect
