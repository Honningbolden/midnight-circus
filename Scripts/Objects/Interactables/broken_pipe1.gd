# broken_pipe1.gd

extends Interactable


@export var mesh : MeshInstance3D
@export var engine : Node3D
@export var door : Node3D
@export var player : Player
@export var label : Label3D
@export var leak_audio_player : AudioStreamPlayer3D
@export var tape_audio_player : AudioStreamPlayer3D

@onready var material = mesh.get_active_material(0)

var fixed : bool = false


func use(_player: Player) -> void:
	if GameManager.current_item == "DuctTape":
		GameManager.current_item = ""
		
		mesh.visible = true
		
		# Duplicate to not effect other objs of same material
		var unique_material = material.duplicate()
		unique_material.albedo_color = Color(1, 0, 0)  # Red
		mesh.set_surface_override_material(0, unique_material)
		fixed = true
		
		if engine.fixed:
			if door: door.use(player)
		
		leak_audio_player.stop()  # Stops the steam leaking sound
		tape_audio_player.play()  # Play the duct tape sound
		label.queue_free()
