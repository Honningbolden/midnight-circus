extends Interactable

@export var door : Node3D
@export var body : StaticBody3D

var open = false
func use (_player : Player) -> void:
	if not open:
		open = true
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(door, "position", Vector3(door.position.x, door.position.y + 3.55, door.position.z), 2)
		tween.tween_property(body, "position", Vector3(body.position.x, body.position.y + 3.55, body.position.z), 2)
