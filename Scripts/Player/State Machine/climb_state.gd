## climb_state.gd


extends StateMachineState


@export_category("Components")
@export var player : Player
@export var camera : Camera3D
@export var ladder_timer : Timer

@export_category("Ladder Constants")
@export var climb_speed : float = 0.02

var ladder : Node3D = null
var ladder_pathfollow : PathFollow3D = null

var ladder_direction : Vector3 = Vector3.ZERO
var last_progress : float = 0.0


func on_enter() -> void:
	player.position = Vector3.ZERO
	player.velocity = Vector3.ZERO
	var ladder = ladder_pathfollow.get_parent().get_parent()
	default_variables()
	camera.look_at_position(player.global_position + ladder_direction)


func default_variables() -> void:
	player.position = Vector3.UP
	player.velocity = Vector3.ZERO
	last_progress = 0.0


func on_process(_delta: float) -> void:
	player.update_input()  # take the player's input


func on_physics_process(_delta: float) -> void:
	climb_ladder()
	check_progress()


func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		change_state("Exploration State")


func climb_ladder() -> void:
	var direction = player.vertical_direction
	ladder_pathfollow.progress += -climb_speed * direction


## Check if the player has reached either end
func check_progress() -> void:
	if ladder_pathfollow.progress_ratio != last_progress:
		if ladder_pathfollow.progress_ratio in [0.0, 1.0]:
			attempt_state_change("Exploration State")
	if ladder_pathfollow:
		last_progress = ladder_pathfollow.progress_ratio


func attempt_state_change(state: String) -> void:
	if ladder_timer.is_stopped():
		change_state(state)


func on_exit() -> void:
	ladder.ladder_finished()
