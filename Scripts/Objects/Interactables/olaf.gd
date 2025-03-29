# olaf.gd


extends Interactable


func use():
	if GameManager.collected_items.has("Vodka"):
		GameManager.collected_items.erase("Vodka")
		GameManager.collected_items.append("Circus Key")
		# TASK: Add an animation Giving the Vodka to Olaf
		# TASK: Add a sound effect for Olaf gving the key
		
	else:
		pass
		# TASK: Add a sound effect for when the player doesn't have vodka
