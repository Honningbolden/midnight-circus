# olaf.gd


extends Interactable

@export var gameworld : Node3D
@export var keys_player : AudioStreamPlayer3D
@export var snore_player : AudioStreamPlayer3D
@export var mumble_player : AudioStreamPlayer3D
@export var key_scene : PackedScene

@export var mumble_audio1 : AudioStream
@export var mumble_audio2 : AudioStream
@export var mumble_audio3 : AudioStream


func use(_player: Player) -> void:
	if GameManager.current_item == "Vodka":
		GameManager.current_item = ""  # take away the vodka
		
		var key = key_scene.instantiate()
		gameworld.add_child(key)
		key.global_position = self.global_position + Vector3(1, 0, 0)
		
		keys_player.play()
		snore_player.stop()
	else:
		var mumbles = [ mumble_audio1, mumble_audio2, mumble_audio3 ]
		var idx = randi() % mumbles.size()
		
		mumble_player.stop()
		mumble_player.stream = mumbles[idx]
		mumble_player.play()


## Wait x seconds
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
