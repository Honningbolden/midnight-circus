# broken_pipe2.gd

extends Interactable


@export var broken_pipe : Node3D
@export var fixed_pipe : Node3D
@export var engine : Node3D
@export var door1 : Node3D
@export var door2 : Node3D
@export var door3 : Node3D
@export var player : Player
@export var label : Label3D
@export var leak_audio_player : AudioStreamPlayer3D

var fixed : bool = false


func use(_player: Player) -> void:
	if GameManager.current_item == "ReplacementPipe":
		GameManager.current_item = ""
		
		broken_pipe.visible = false
		fixed_pipe.visible = true
		
		fixed = true
		
		if engine.fixed:
			if door1: door1.use(player)
			if door2: door2.use(player)
			if door3: door3.use(player)
		
		leak_audio_player.stop()
		label.queue_free()
