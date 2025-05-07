extends Interactable

@export var enabled = false
@onready var mesh = $MeshInstance3D
@onready var material = mesh.get_active_material(0)

func use(_player: Player) -> void:
	if not enabled and GameManager.current_item == "Fuse":
		GameManager.current_item = ""
		enabled = true
		
		# Duplicate to not effect other objs of same material
		var unique_material = material.duplicate()
		unique_material.albedo_color = Color(0, 1, 0)  # Green
		mesh.set_surface_override_material(0, unique_material)
		
		$Label3D.queue_free()

		
