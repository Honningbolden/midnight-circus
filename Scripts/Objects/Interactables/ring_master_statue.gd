extends Node3D

@onready var rightArm = $RightArm
@onready var leftArm = $LeftArm
@onready var leftFoot = $LeftFoot
@onready var rightFoot = $RightFoot

@onready var mesh = $MeshInstance3D
@onready var material = mesh.get_active_material(0)

@onready var RFmesh = $RightFoot/MeshInstance3D
@onready var RFmaterial = RFmesh.get_active_material(0)
@onready var LFmesh = $LeftFoot/MeshInstance3D
@onready var LFmaterial = LFmesh.get_active_material(0)
@onready var LAmesh = $LeftArm/MeshInstance3D
@onready var LAmaterial = LAmesh.get_active_material(0)
@onready var RAmesh = $RightArm/MeshInstance3D
@onready var RAmaterial = RAmesh.get_active_material(0)

@onready var check1 = false
@onready var check2 = false


func _process(_delta):
	if not check1 and rightArm.state == 2 and leftArm.state == 2 and leftFoot.state == 2:
		check1= true  # ensures that the code runs only once instead of every frame after states are correct
		material.albedo_color = Color(0, 1, 0)  # Green
		mesh.set_surface_override_material(0, material); RFmesh.set_surface_override_material(0, material) 
		leftFoot.get_node("Label3D").queue_free(); leftArm.get_node("Label3D").queue_free(); rightArm.get_node("Label3D").queue_free()
		leftFoot.enabled = false; rightArm.enabled = false; leftArm.enabled = false
		$FuseSlot1.show(); $FuseSlot2.show(); $FuseSlot3.show()
		
	if not check2 and $FuseSlot1.enabled == true and $FuseSlot2.enabled == true and $FuseSlot3.enabled == true:
		check2 = true
		material.albedo_color = Color(0, 0, 1)  # Blue
		mesh.set_surface_override_material(0, material)
		LFmesh.set_surface_override_material(0, material); RFmesh.set_surface_override_material(0, material)
		LAmesh.set_surface_override_material(0, material); RAmesh.set_surface_override_material(0, material) 
		$FuseSlot1.queue_free(); $FuseSlot2.queue_free(); $FuseSlot3.queue_free()
		
