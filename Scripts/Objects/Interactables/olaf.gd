# olaf.gd


extends Interactable

@export var key : Node3D

func use(_player: Player) -> void:
	if GameManager.current_item == "Vodka":
		GameManager.current_item = ""
		await wait(1) #waits 1 second before giving you item
		key.position = self.global_position
		key.position.x += 1
		# TASK: Add an animation Giving the Vodka to Olaf
		# TASK: Add a sound effect for Olaf gving the key
	else:
		pass
		# TASK: Add a sound effect for when the player doesn't have vodka

func wait(seconds: float) -> void:        # Thanks to GBWD on the Godot forum
	await get_tree().create_timer(seconds).timeout
