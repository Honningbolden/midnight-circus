## circus_speaker.gd


extends Node3D


@export var circus_audio_player : AudioStreamPlayer3D
@export var game_music_player : AudioStreamPlayer

var activated : bool = false


func _on_circus_entered(body: Node3D) -> void:
	if body is Player and not activated:
		activated = true
		game_music_player.stop()
		circus_audio_player.play(0.0)
