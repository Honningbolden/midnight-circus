# broken_pipe.gd

extends Interactable
@onready var mesh = $MeshInstance3D
@onready var material = mesh.get_active_material(0)

func use(_player: Player) -> void:
	if GameManager.current_item == "DuctTape" or GameManager.current_item == "ReplacementPipe":
		GameManager.current_item = ""
		
		# Duplicate to not effect other objs of same material
		var unique_material = material.duplicate()
		unique_material.albedo_color = Color(0, 1, 0)  # Green
		mesh.set_surface_override_material(0, unique_material)
		
		$Leak.stop() # Stops the sound of steam leaking from the pipe
		$DuctTape.play()
		$Label3D.queue_free()
		
		# TASK: Add an animation for fixing pipe
