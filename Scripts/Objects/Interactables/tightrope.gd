## tightrope.gd


extends Node3D


@export var pathfollow : PathFollow3D
@export var tightrope_area : Area3D
@export var start_marker : Marker3D
@export var end_marker : Marker3D
@export var cooldown_timer : Timer
@export var gameworld : Node3D
@export var player : Player


func _on_tightrope_body_entered(body: Node3D) -> void:
	if body is Player and cooldown_timer.is_stopped():
		cooldown_timer.start()
		var tightrope_state = body.statemachine.get_node("Tightrope State")
		tightrope_area.set_deferred("monitoring", false)
		
		adjust_pathfollow(body)
		tightrope_state.rope_direction = 1.0 if is_near_end(body) else -1.0
		tightrope_state.tightrope = self
		tightrope_state.tightrope_pathfollow = pathfollow
		player = body
		body.reparent(pathfollow)
		body.statemachine.change_state("Tightrope State")


## Detects if the player is closer to the beginning or end of the tightrope
func is_near_end(player: Player) -> bool:
	var dist_to_start = player.global_position.distance_to(start_marker.global_position)
	var dist_to_end = player.global_position.distance_to(end_marker.global_position)
	if dist_to_start < dist_to_end:
		return true
	return false


## Adjust the pathfollow progress to closest side of the player
func adjust_pathfollow(player: Player) -> void:
	if is_near_end(player):
		pathfollow.progress_ratio = 0.0
	else:
		pathfollow.progress_ratio = 1.0


func tightrope_finished() -> void:
	cooldown_timer.start()
	pathfollow.rotation.z = 0.0
	tightrope_area.set_deferred("monitoring", true)
	player.call_deferred("reparent", gameworld)
	
	var new_pos = start_marker.global_position if is_near_end(player) else end_marker.global_position
	player.global_position = new_pos + (Vector3.UP * 0.85)
