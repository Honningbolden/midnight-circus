# player.gd


extends CharacterBody3D
class_name Player


@export_category("Components")
@export var raycast : RayCast3D
@export var statemachine : FiniteStateMachine

@export_category("Movement Variables")
@export var walking_threshold : float = 0.1  # minimum speed required to walk
@export var sprite_segments : int = 8  # how many directions can the player turn
@export var acceleration : float = 0.21  # takes 0.4 seconds to reach max speed
@export var deceleration : float = 0.42  # takes 0.2 seconds to come to a stop
@export var deadzone : float = 0.3  # controller deadzone

@export_category("Gravity Variables")
@export var fall_speed : float = -5.0  # the max falling speed
@export var fall_gravity : float = -0.5  # the player's gravity


# Character helpers
var speed : float = 0.0  # the player's current max speed
var walking_speed : float = 3.0  # base walking speed
var running_speed : float = 6.0  # base running speed
var forward_direction : float = 0.0  # the direction the camera is looking
var horizontal_direction : float = 0.0  # the player's left and right input
var vertical_direction : float = 0.0  # the player's back and forth input
var last_direction : float = PI / 2  # the player's most recent direction
var spawn_position : Vector3 = Vector3.ZERO  # place the player first starts
var current_interactable : Node3D = null  # current interactable object
var last_interactable : Node3D = null  # last interactable object

# State conditions
var can_move : bool = false  # can the player move
var can_turn : bool = false  # can the player turn


func _ready() -> void:
	can_move = true
	can_turn = true
	speed = walking_speed


func _process(_delta: float) -> void:  # every graphics frame
	update_interactable_text()


func _physics_process(_delta: float) -> void:  # every physics frame
	move_and_slide()  # detect movement and collisions


func _input(_event: InputEvent) -> void:  # every input event
	pass


#region Character Helpers
## Take the user's movement input
func update_input() -> void:
	if can_move:  # if the player is allowed to move
		# set their horizontal direction to left [-1.0] or right [1.0]
		horizontal_direction = Input.get_axis("left", "right")
		# set their depth direction to up [-1.0] or down [1.0]
		vertical_direction = Input.get_axis("up", "down")
	else:  # if the player is not allowed to move
		horizontal_direction = 0  # set their horizontal direction to 0.0
		vertical_direction = 0  # set their depth direction to 0.0


## Adjust the player's velocity
func update_velocity() -> void:
	# create the input direction using horizontal and depth inputs
	var input_direction = Vector3(horizontal_direction, 0, vertical_direction)
	# if the player's input is greater than the deadzone
	if input_direction.length() >= deadzone:
		input_direction = input_direction.normalized()  # normalize the input
		# rotate the input direction to point forward
		input_direction = input_direction.rotated(Vector3.UP, forward_direction)
		# accelerate the velocity towards max speed using acceleration
		velocity = velocity.move_toward(input_direction * speed, acceleration)
	else:  # if the input is less than the deadzone
		# decelerate the velocity to zero using deceleration
		velocity = velocity.move_toward(Vector3.ZERO, deceleration)


## Adjust the player's falling speed
func update_gravity() -> void:
	# if the player is in the air and their velocity isn't maxed out
	if not is_on_floor() and velocity.y >= fall_speed:
		# accumulate speed using gravity until reaching max fall speed
		velocity.y = max(velocity.y + fall_gravity, fall_speed)


#region Interactions
## Interact with oldest nearby item
func interact():
	var item = get_interactable()
	if item is Collectible:
		item.collect()
	elif item is Interactable:
		item.use(self)


## Get the first interactable the raycast hits
func get_interactable() -> Node3D:
	if raycast.is_colliding():
		var interactable_area = raycast.get_collider()
		if interactable_area != null:
			return interactable_area.get_parent()
	return null


func update_interactable_text() -> void:
	current_interactable = get_interactable()
	display_interactable_text()
	hide_interactable_text()
	last_interactable = get_interactable()


func display_interactable_text() -> void:
	if current_interactable and current_interactable.has_node("Label3D"):
		var label = current_interactable.get_node("Label3D")
		label.show()


func hide_interactable_text() -> void:
	if last_interactable and current_interactable != last_interactable:
		if last_interactable.has_node("Label3D"):
			var label = last_interactable.get_node("Label3D")
			label.hide()
#endregion
