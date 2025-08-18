# safe.gd

extends Interactable


@export var gameworld : Node3D
@export var puzzle : Node2D
@export var player : Player
@export var safe_door : Node3D
@export var area : Area3D
@export var label : Label3D
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
		
		coin.global_position = self.global_position + Vector3(-0.3, -0.3, 0)
		coin.rotation_degrees.y = -90.0
		
		var tween = create_tween()
		tween.tween_property(safe_door, "rotation_degrees", Vector3(0, -115, 0), 1.0)
		disable_interactable()


func disable_interactable() -> void:
	area.queue_free()
	label.queue_free()
