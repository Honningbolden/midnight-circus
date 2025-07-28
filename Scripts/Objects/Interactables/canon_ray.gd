extends RayCast3D

func _process(delta: float) -> void:
	if is_colliding():
		var collider = self.get_collider()
		#print("colliding with:", collider)
