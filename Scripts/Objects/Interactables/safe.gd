# safe.gd

extends Interactable
@onready var puzzle = $Lock
@onready var player = get_node("../Player")
@onready var puzzle_complete = false
@export var coin : Node3D

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
	if puzzle_complete:
		coin.global_position = self.global_position + Vector3(0, 0.5, 0)
