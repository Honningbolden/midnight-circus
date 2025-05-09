# canon.gd

extends Interactable


func use(player: Player) -> void:
	player.statemachine.change_state("Canon State")
