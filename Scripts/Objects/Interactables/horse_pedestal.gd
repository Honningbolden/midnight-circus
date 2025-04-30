# CLARIFY COLLECTED ITEMS CODE AND THAT THE PLAYER CAN ONLY EQUIP 1 ITEM
# CODE IS BASED ON THE FACT THAT THE PLAYER CAN ONLY HAVE 1 ITEM AT A TIME
extends Interactable

@export var number = 1
@export var has_tag = false
@export var current_tag = "None"
@export var has_correct_tag = false

var puzzle_finished = false

func use(_player: Player) -> void:
	# player cant mess with pedestals after finishing the puzzle
	if puzzle_finished:
		return
	# state 1 if no tag, allow player to place any horse tag they havew (users can only have 1 item at a time apparently
	if not has_tag:
		if GameManager.collected_items.size() > 0:
			current_tag = GameManager.collected_items.pop_front()
			has_tag = true
			taglight(has_tag)
			# if correct tag, change var
			if int(current_tag[-1]) == number:
				has_correct_tag = true
			$Label3D.text = "Take Horse Tag"
	
	# state 2 if there is a placed tag, allow player to retrieve the placed tag		
	elif has_tag:
		# if player has an equipped tag, switch tags with the current placed tag
		if GameManager.collected_items.size() > 0:
			GameManager.collected_items.append(current_tag)
			current_tag = GameManager.collected_items.pop_front()
			taglight(true)
			# this is really bad coding practice
			if int(current_tag[-1]) == number:
				has_correct_tag = true
			else: 
				has_correct_tag = false
				
		# take tag on pedestal and equip on player
		else:
			GameManager.collected_items.append(current_tag)
			has_tag = false
			taglight(has_tag)
			current_tag = "None"
			has_correct_tag = false
			$Label3D.text = "Place Horse Tag"
	

# controls the child node tagindicator
func taglight(switch: bool) -> void:
	if switch:
		#print(current_tag)
		# get child node 
		var mesh = $TagIndicator/MeshInstance3D
		var material = mesh.get_active_material(0)
		
		#TEST
		#var tag = get_tree().current_scene.find_child(current_tag, true, false)
		#if tag:
		#	print('yes king')
		#print(tag)
		
		# get color from placed horsetag
		material.albedo_color = get_tree().current_scene.find_child(current_tag, true, false).get_node("Sprite3D").modulate
		mesh.set_surface_override_material(0, material)
		$TagIndicator.show()
	else:
		$TagIndicator.hide()
		
	
