## exploration_state.gd


extends StateMachineState


@export var player : Player
@export var camera : Camera3D


# Called when the state machine enters this state.
func on_enter() -> void:
	pass


# Called every frame when this state is active.
func on_process(_delta: float) -> void:
	player.update_input()  # take the player's input


# Called every physics frame when this state is active.
func on_physics_process(_delta: float) -> void:
	player.update_velocity()  # move the player laterally
	player.update_gravity()  # move the player vertically


# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("sprint"):  # if 'sprint' is pressed
		player.speed = player.running_speed  # run faster
	if event.is_action_released("sprint"):  # if 'sprint' is released
		player.speed = player.walking_speed  # run slower
	if event.is_action_pressed("interact"):
		player.interact()
	if event is InputEventMouseMotion:  # if mouse moved
		camera.update_camera_input(event.relative)  # update the camera
	if event is InputEventJoypadMotion:  # if joystick moved
		camera.update_camera_input(camera.get_joy_direction())


# Called when the state machine exits this state.
func on_exit() -> void:
	pass


# Called when the state machine's AnimationPlayer emits the 'animation_started' signal.
func on_animation_started(_anim_name: StringName) -> void:
	pass


# Called when the state machine's AnimationPlayer emits the 'animation_finished' signal.
func on_animation_finished(_anim_name: StringName) -> void:
	pass


# Called when the state machine's AnimationPlayer emits the 'animation_changed' signal.
func on_animation_changed(_old_name: StringName, _new_name: StringName) -> void:
	pass
