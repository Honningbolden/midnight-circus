extends Collectible

func collect():
	if GameManager.current_item == "":
		GameManager.pickup(name)
		await wait(0.01)
		self.global_position -= Vector3(50, 50, 50)
	print(GameManager.current_item)

func wait(seconds: float) -> void:        # Thanks to GBWD on the Godot forum
	await get_tree().create_timer(seconds).timeout
