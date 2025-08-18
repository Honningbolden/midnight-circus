# steam_engine.gd

extends Interactable


@export var valve : MeshInstance3D
@export var broken_pipe1 : Node3D
@export var broken_pipe2 : Node3D
@export var door : Node3D
@export var player : Player
@export var audio_player : AudioStreamPlayer3D

var fixed : bool = false


func use(_player: Player) -> void:
	if not fixed and GameManager.current_item == "Valve":
		audio_player.play()
		broken_pipe1.leak_audio_player.play()
		broken_pipe2.leak_audio_player.play()
		
		valve.visible = true
		var tween = create_tween()
		tween.tween_property(valve, "rotation_degrees", Vector3(90,0,0), 1)
		if GameManager.current_item == "Valve":
			GameManager.current_item = ""
		fixed = true
		
		if broken_pipe1.fixed:
			door.use(player)
