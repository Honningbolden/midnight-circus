# vending_machine.gd


extends Interactable


func use():
	if GameManager.collected_items.has("Coin"):
		GameManager.collected_items.erase("Coin")
		GameManager.collected_items.append("Vodka")
		# TASK: Add an animation showing the vodka being ejected
		# TASK: Add a sound effect to indicate the vodka has been dispensed
		
	else:
		pass
		# TASK: Add a sound effect for when the player doesn't have a coin
