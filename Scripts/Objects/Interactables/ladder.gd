## ladder.gd


extends Node3D


@export var pathfollow : PathFollow3D
@export var ladder_area : Area3D
@export var start_marker : Marker3D
@export var end_marker : Marker3D
@export var cooldown_timer : Timer
@export var gameworld : Node3D
@export var player : Player


func _on_ladder_body_entered(body: Node3D) -> void:
	if body is Player and cooldown_timer.is_stopped():
		cooldown_timer.start()
		var ladder_state = body.statemachine.get_node("Ladder State")
		ladder_area.set_deferred("monitoring", false)
		
		adjust_pathfollow(body)
		var start_pos = start_marker.global_position
		var end_pos = end_marker.global_position
		ladder_state.ladder_direction = start_pos.direction_to(end_pos)
		ladder_state.ladder = self
		ladder_state.ladder_pathfollow = pathfollow
		player = body
		body.reparent(pathfollow)
		body.statemachine.change_state("Ladder State")


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


func ladder_finished() -> void:
	cooldown_timer.start()
	pathfollow.rotation.z = 0.0
	ladder_area.set_deferred("monitoring", true)
	player.call_deferred("reparent", gameworld)
	
	var new_pos = start_marker.global_position if is_near_end(player) else end_marker.global_position
	player.global_position = new_pos + (Vector3.UP * 0.85)
