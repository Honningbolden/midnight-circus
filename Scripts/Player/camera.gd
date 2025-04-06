## camera.gd


extends Camera3D


@export_category("Components")
@export var player : CharacterBody3D  # the player node
@export var listener : AudioListener3D  # the audio listener
@export var raycast : RayCast3D  # the interaction raycast
@export var hands : Node3D

@export_category("Camera Variables")
@export var camera_sensitivity : float = 0.1  # how quickly the camera turns
@export var pitch_max : float = TAU / 4.5  # how far up can the camera look
@export var pitch_min : float = -PI / 3  # how far down can the camera look
@export var camera_smoothness : float = 0.2  # camera update step size

# Camera helpers
var target_pitch : float = 0.0  # vertical angle the player wants to look
var camera_pitch : float = 0.0  # vertical angle of the camera
var target_forward : float = 0.0  # the direction the player wants to look
var locked : bool = false  # disallows camera movement


## This section will automate all camera movement
#region Internals
func _ready() -> void:  # when the camera is ready
	setup_camera()


func _process(_delta: float) -> void:  # every graphics frame
	if player.can_turn and not locked:  # if the player is alive
		update_camera()  # update the camera's rotation


## Animate the camera into position
func setup_camera() -> void:
	# tween the camera into positions
	rotation = Vector3.ZERO


## Get joystick direction from controller
## Return a motion vector to feed update_camera_input()
func get_joy_direction() -> Vector2:
	var horizontal_direction = Input.get_axis("camera_left", "camera_right")
	var vertical_direction = Input.get_axis("camera_down", "camera_up") * -1
	return Vector2(horizontal_direction, vertical_direction) * 10


## Update the camera direction
func update_camera_input(motion: Vector2) -> void:
	# update the target forward direction and target camera pitch
	target_forward -= deg_to_rad(motion.x * camera_sensitivity)
	target_pitch -= deg_to_rad(motion.y * camera_sensitivity)
	target_pitch = clamp(target_pitch, pitch_min, pitch_max)


## Interpolate the camera toward the target direction
func update_camera() -> void:
	# interpolate forward direction and camera pitch towards targets
	player.forward_direction = lerp_angle(player.forward_direction, target_forward, camera_smoothness)
	camera_pitch = lerp_angle(camera_pitch, target_pitch, camera_smoothness)
	
	# calculate the new camera position and rotation
	rotation = Vector3(camera_pitch, player.forward_direction, 0)
	listener.rotation = rotation
	raycast.rotation = rotation
	hands.rotation = rotation
#endregion


## Snap the camera to look at a point
func set_camera() -> void:
	# interpolate forward direction and camera pitch towards targets
	player.forward_direction = target_forward
	camera_pitch = target_pitch
	
	# calculate the new camera position and rotation
	rotation = Vector3(camera_pitch, player.forward_direction, 0)
	listener.rotation = rotation
	raycast.rotation = rotation
	hands.rotation = rotation


## Slowly rotate the camera to look at a point
func look_at_position(world_position: Vector3) -> void:
	print(target_forward)
	var camera_position = global_position
	var to_target = camera_position - world_position
	var flat_dir = Vector2(to_target.x, to_target.z)
	
	if flat_dir.length() > 0.0001:
		target_forward = atan2(flat_dir.x, flat_dir.y)
