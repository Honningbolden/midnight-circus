# GameManager Singleton


extends Node

var total_items = []  # all available items
var collected_items = []  # picked up items


func _ready() -> void:  # when the node is ready
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # hide the mouse


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):  # if user hits escape
		change_mouse_mode()  # change mode of mouse


## Toggle mouse between hidden and visible
func change_mouse_mode() -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
