# canon.gd

extends Interactable
@export var canon: Node3D
@export var ray: RayCast3D
var loaded = true


func use(player: Player) -> void:
	var canon_state = player.statemachine.get_node("Canon State")
	canon_state.canon = canon
	if loaded:
		player.reparent(canon)
		player.statemachine.change_state("Canon State")
		player.position = Vector3(0, 1, 0)
		canon.ray.visible = true
	else:
		if GameManager.current_item == "Canonball":
			GameManager.current_item = ""
			loaded = true
	
func fire() -> void:
	var explosion = canon.get_node("Explosion")
	explosion.explode()
