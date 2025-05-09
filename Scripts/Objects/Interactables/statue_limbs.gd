extends Interactable

@export var enabled = true
@export var state = 1    # controls what state the part is in
@onready var mesh = $MeshInstance3D
@onready var material = mesh.get_active_material(0)

func use(_player: Player) -> void:
	if not enabled:
		return
	var unique_material = material.duplicate()
	if state == 1:
		state = 2
		unique_material.albedo_color = Color(0, 1, 0)  # Green
	elif state == 2:
		state = 3
		unique_material.albedo_color = Color(1, 0, 0)  # Red
	elif state == 3:
		state = 1
		unique_material.albedo_color = Color(0, 0, 1)
	mesh.set_surface_override_material(0, unique_material)
