# safe.gd

extends Interactable
@onready var puzzle = $Lock
@onready var player = get_node("../Player")

func use(_player: Player) -> void:
	puzzle.initialize()
	puzzle.show()
	player.can_move = false
	player.can_turn = false
	player.visible = false
	

func puzzle_end() -> void:
	puzzle.hide()
	player.can_move = true
	player.can_turn = true
	player.visible = true


# add code to prevent user from being able to interact with safe again after finishing puzzle
