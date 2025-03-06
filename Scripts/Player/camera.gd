## camera.gd


extends Camera3D


@export_category("Components")
@export var player : CharacterBody3D  # the player node
@export var listener : AudioListener3D  # the audio listener

@export_category("Camera Variables")
@export var camera_distance : float = 0.7  # distance between player and camera
@export var camera_height : float = 0.5  # height of the camera from floor
@export var camera_sensitivity : float = 0.1  # how quickly the camera turns
@export var height_scalar : float = 1.1  # how quickly camera height changes
@export var pitch_max : float = TAU / 9  # how far up can the camera look
@export var pitch_min : float = -PI / 9  # how far down can the camera look
@export var camera_smoothness : float = 0.2  # camera update step size

# Camera helpers
var target_pitch : float = 0.0  # vertical angle the player wants to look
var camera_pitch : float = 0.0  # vertical angle of the camera
var target_forward : float = 0.0  # the direction the player wants to look


func _ready() -> void:  # when the camera is ready
	setup_camera()


func _process(_delta: float) -> void:  # every graphics frame
	if player.can_turn:  # if the player is alive
		update_camera()  # update the camera's position and rotation
		update_camera_input(get_joy_direction())


func _input(event: InputEvent) -> void:  # every input event
	if event is InputEventMouseMotion and player.can_turn:  # if mouse moved
		update_camera_input(event.relative)  # update the camera


func get_joy_direction() -> Vector2:
	var horizontal_direction = Input.get_axis("camera_left", "camera_right")
	var vertical_direction = Input.get_axis("camera_down", "camera_up") * -1
	var vec = Vector2(horizontal_direction, vertical_direction) * 10
	return vec


## Animate the camera into position
func setup_camera() -> void:
	# find the final camera position
	var camera_position = Vector3(0.0, camera_height, camera_distance)
	var animation_duration = 1.0  # length of the animation
	
	# tween the camera into positions
	position = camera_position
	rotation = Vector3.ZERO


## Update the camera position and rotation
func update_camera_input(motion: Vector2) -> void:
	# update the target forward direction and target camera pitch
	target_forward -= deg_to_rad(motion.x * camera_sensitivity)
	target_pitch -= deg_to_rad(motion.y * camera_sensitivity)
	target_pitch = clamp(target_pitch, pitch_min, pitch_max)


## Interpolate the camera toward the target position and rotation
func update_camera() -> void:
	# interpolate forward direction and camera pitch towards targets
	player.forward_direction = lerp_angle(player.forward_direction, target_forward, camera_smoothness)
	camera_pitch = lerp_angle(camera_pitch, target_pitch, camera_smoothness)
	
	# calculate the new camera position and rotation
	var x = sin(player.forward_direction) * camera_distance
	var y = -sin(camera_pitch) * height_scalar + camera_height
	var z = cos(player.forward_direction) * camera_distance
	rotation = Vector3(camera_pitch, player.forward_direction, 0)
	position = Vector3(x, y, z)
	
	# calculate the new listener rotation
	listener.rotation = rotation


func set_camera() -> void:
	# interpolate forward direction and camera pitch towards targets
	player.forward_direction = target_forward
	camera_pitch = target_pitch
	
	# calculate the new camera position and rotation
	var x = sin(player.forward_direction) * camera_distance
	var y = -sin(camera_pitch) * height_scalar + camera_height
	var z = cos(player.forward_direction) * camera_distance
	rotation = Vector3(camera_pitch, player.forward_direction, 0)
	position = Vector3(x, y, z)
	
	# calculate the new listener rotation
	listener.rotation = rotation


## Calculate the bit value of a set of layers
func calculate_mask(layers: Array) -> int:
	var mask : int = 0  # begin counting from 0
	for i in layers:  # for each layer
		mask += 1 << (i - 1)  # accumulate the bit value
	return mask  # return the resulting bit value
