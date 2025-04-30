# safe.gd

extends Interactable
@onready var puzzle = $Lock
@onready var player = get_node("../Player")
@onready var puzzle_complete = false

func use(_player: Player) -> void:
	if puzzle_complete: 
		return
	puzzle.initialize()
	puzzle.show()
	player.can_move = false
	player.can_turn = false
	player.visible = false
	

func puzzle_end(puzzle_status) -> void:
	puzzle.hide()
	player.can_move = true
	player.can_turn = true
	player.visible = true
	puzzle_complete = puzzle_status


# add code to prevent user from being able to interact with safe again after finishing puzzle
