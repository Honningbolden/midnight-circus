# canon.gd

extends Interactable

var is_on  = false

func use(player: Player) -> void:
	if GameManager.current_item == "Battery" or is_on:
		is_on = true
		player.statemachine.change_state("Canon State")
