# canon.gd

extends Interactable
@export var canon: Node3D
@export var ray: RayCast3D

func use(player: Player) -> void:
	var canon_state = player.statemachine.get_node("Canon State")
	canon_state.canon = canon
	player.reparent(canon)
	player.statemachine.change_state("Canon State")

func fire() -> void:
	var explosion = canon.get_node("Explosion")
	explosion.explode()
