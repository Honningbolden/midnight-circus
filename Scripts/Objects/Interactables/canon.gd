# canon.gd

extends Interactable

@export var camera: Camera3D

func use(player: Player) -> void:
	var canon_state = player.statemachine.get_node("Canon State")
	canon_state.canon = self
	player.reparent(self)
	player.statemachine.change_state("Canon State")
