# canon.gd

extends Interactable
@export var pathfollow : PathFollow3D
var loaded = false

func load_canon()-> void:
	if GameManager.collected_items.has("Canon Ball"):
		GameManager.collected_items.erase("Canon Ball")
		# TASK: Add an animation showing the canon ball being loaded
	else:
		pass
		# TASK: Add an indicator showing player needs a canon ball

func aim_canon(player: Player)-> void:
	player.reparent(pathfollow)
	var mount_state = player.statemachine.get_node("Mount State")
	mount_state.ladder_pathfollow = pathfollow
	player.statemachine.change_state("Mount State")

func use(player: Player) -> void:
	if loaded == true:
		aim_canon(player)
	else:
		load_canon()
