extends Interactable

@export var cannonBall : Node3D

var usable = true

func use(_player: Player) -> void:
	if usable:
		usable = false
		var tween = create_tween()
		tween.tween_property(self, "position", Vector3(self.position.x, 1, self.position.z), 0.5).set_trans(tween.TRANS_SINE).set_ease(tween.EASE_IN)
		tween.tween_property(self, "position", Vector3(self.position.x, 2, self.position.z), 0.5).set_trans(tween.TRANS_SINE).set_ease(tween.EASE_IN)
		cannonBall.reparent(self.get_parent())
		tween.tween_property(cannonBall, "position", Vector3(self.position.x, self.position.y - 15.1, self.position.z), 2)
		
