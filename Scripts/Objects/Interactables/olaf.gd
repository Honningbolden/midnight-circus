# olaf.gd


extends Interactable


func use(_player: Player) -> void:
	if GameManager.current_item == "Vodka":
		GameManager.current_item == ""
		GameManager.pickup("Circus Key")
		# TASK: Add an animation Giving the Vodka to Olaf
		# TASK: Add a sound effect for Olaf gving the key
	else:
		pass
		# TASK: Add a sound effect for when the player doesn't have vodka
