## ladder.gd


extends Interactable


@export var pathfollow : PathFollow3D


func use(player: Player) -> void:
	player.reparent(pathfollow)
	var climb_state = player.statemachine.get_node("Climb State")
	climb_state.ladder_pathfollow = pathfollow
	player.statemachine.change_state("Climb State")
