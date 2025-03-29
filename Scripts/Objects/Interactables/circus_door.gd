# circus_door1.gd


extends Interactable


func use():
	if GameManager.collected_items.has("Circus Key"):
		GameManager.collected_items.erase("Circus Key")
		# TASK: sliding door or swinging door?
		# TASK: Add an animation showing the door opening
		# TASK: Add a sound effect for the door opening
		
	else:
		pass
		# TASK: Add a sound effect for when the player doesn't have the key
