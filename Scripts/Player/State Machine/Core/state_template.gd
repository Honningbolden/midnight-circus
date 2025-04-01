extends StateMachineState


# Called when the state machine enters this state.
func on_enter() -> void:
	pass


# Called every frame when this state is active.
func on_process(_delta: float) -> void:
	pass


# Called every physics frame when this state is active.
func on_physics_process(_delta: float) -> void:
	pass


# Called when there is an input event while this state is active.
func on_input(_event: InputEvent) -> void:
	pass


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
