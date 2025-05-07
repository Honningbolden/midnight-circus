# vending_machine.gd

extends Interactable

func wait(seconds: float) -> void:        # Thanks to GBWD on the Godot forum
	await get_tree().create_timer(seconds).timeout

func use(_player: Player) -> void:
	if GameManager.current_item == "Coin":
		GameManager.current_item = ""
		$CoinAccept.play()
		
		await wait(1) #waits 1 second before giving you item
		# TASK: Add an animation showing the vodka being ejected
				
	else:
		$CoinDeny.play()
		
		
