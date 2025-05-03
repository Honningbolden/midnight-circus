extends Interactable


func use (_player : Player) -> void:
	var tween = create_tween()
	tween.tween_property(self, "position", Vector3(self.position.x, self.position.y + 3.55, self.position.z), 2)
