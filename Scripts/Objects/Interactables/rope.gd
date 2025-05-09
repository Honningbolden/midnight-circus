extends Interactable

@export var cannonball : Node3D

var usable = true

func use(_player: Player) -> void:
	if usable:
		usable = false
		var tween = create_tween()
		var x = cannonball.global_position.x
		var y = 0.7
		var z = cannonball.global_position.z
		tween.tween_property(cannonball, "global_position", Vector3(x, y, z), 2)
