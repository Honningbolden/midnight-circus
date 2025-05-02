extends Node


@export var pathfollow : PathFollow3D
@export var start_marker : Marker3D
@export var end_marker : Marker3D
@export var timer : Timer

var world : Node3D = null
var active : bool = false
var last_progress : float = 0.0


func _process(delta: float) -> void:
	if pathfollow.progress_ratio != last_progress:
		if pathfollow.progress_ratio in [0.0, 1.0]:
			_on_tightrope_body_exited(pathfollow.get_child(0))
	last_progress = pathfollow.progress_ratio


func _on_tightrope_body_entered(body: Node3D) -> void:
	if body is Player and timer.is_stopped():
		timer.start()
		adjust_pathfollow(body)
		body.reparent(pathfollow)
		world = body.get_parent()
		if pathfollow.has_node("Player"):
			var tightrope_state = body.statemachine.get_node("Tightrope State")
			if is_near_end(body):
				tightrope_state.rope_direction = 1.0
			else:
				tightrope_state.rope_direction = -1.0
			tightrope_state.tightrope_pathfollow = pathfollow
			body.statemachine.change_state("Tightrope State")


func _on_tightrope_body_exited(body: Node3D) -> void:
	if body is Player and timer.is_stopped():
		body.reparent(world)
		body.statemachine.change_state("Exploration State")


func is_near_end(player: Player) -> bool:
	var dist_to_start = player.global_position.distance_to(start_marker.global_position)
	var dist_to_end = player.global_position.distance_to(end_marker.global_position)
	if dist_to_start < dist_to_end:
		return true
	return false


func adjust_pathfollow(player: Player) -> void:
	if is_near_end(player):
		pathfollow.progress_ratio = 0.0
	else:
		pathfollow.progress_ratio = 1.0
