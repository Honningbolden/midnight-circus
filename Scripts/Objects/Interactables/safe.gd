# safe.gd

extends Interactable


@export var gameworld : Node3D
@export var puzzle : Node2D
@export var player : Player
@export var coin_scene : PackedScene

var puzzle_complete = false


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
		var coin = coin_scene.instantiate()
		gameworld.add_child(coin)
		coin.global_position = self.global_position + Vector3(-1, 0, 0)
