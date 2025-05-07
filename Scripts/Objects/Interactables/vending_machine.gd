# vending_machine.gd

extends Interactable

func wait(seconds: float) -> void:        # Thanks to GBWD on the Godot forum
	await get_tree().create_timer(seconds).timeout

func use(_player: Player) -> void:
	if GameManager.collected_items.has("Coin"):
		GameManager.collected_items.erase("Coin")
		$CoinAccept.play()
		
		await wait(1) #waits 1 second before giving you item
		GameManager.collected_items.append("Vodka")
		# TASK: Add an animation showing the vodka being ejected
				
	else:
		$CoinDeny.play()
		
		
