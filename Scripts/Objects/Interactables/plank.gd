## plank.gd

extends Node


@export var pathfollow : PathFollow3D
@export var plank_area : Area3D
@export var start_marker : Marker3D
@export var end_marker : Marker3D
@export var cooldown_timer : Timer

@onready var world : Node3D = get_parent()
var player : Player = null


func _on_plank_body_entered(body: Node3D) -> void:
	print("plank entered")
	if body is Player and cooldown_timer.is_stopped():
		cooldown_timer.start()
		var plank_state = body.statemachine.get_node("Plank State")
		plank_area.set_deferred("monitoring", false)
		
		adjust_pathfollow(body)
		plank_state.plank_direction = 1.0 if is_near_end(body) else -1.0
		plank_state.plank = self
		plank_state.plank_pathfollow = pathfollow
		player = body
		body.reparent(pathfollow)
		body.statemachine.change_state("Plank State")


## Detects if the player is closer to the beginning or end of the plank
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


func plank_finished() -> void:
	cooldown_timer.start()
	pathfollow.rotation.z = 0.0
	plank_area.set_deferred("monitoring", true)
	player.call_deferred("reparent", world)
	
	var new_pos = start_marker.global_position if is_near_end(player) else end_marker.global_position
	player.global_position = new_pos + (Vector3.UP * 0.85)


func _on_plank_body_exited(body: Node3D) -> void:
	pass # Replace with function body.
