
extends Interactable

var has_tag = false
var current_tag = "None"
var has_correct_tag = false

func use(_player: Player) -> void:
	print("horse1")
	if has_tag == false:
		if GameManager.collected_items.has("HorseTag1"):
			GameManager.collected_items.erase("HorseTag1a")
			
			# Add sfx/animation
	else:
		GameManager.collected_items.append("current_tag")
		pass
