extends Node3D

@onready var check1 = false
@onready var check2 = false

func _process(_delta):
	#only allow puzzle to be started when ring master statue puzzle is solved
	if not check1 and get_node("../RingMasterStatue").check1 == true:
		check1 = true
		$HorsePedestal1.puzzle_activated = true
		$HorsePedestal2.puzzle_activated = true
		$HorsePedestal3.puzzle_activated = true
		$HorsePedestal4.puzzle_activated = true
		$HorsePedestal5.puzzle_activated = true
		$HorsePedestal6.puzzle_activated = true
		$HorsePedestal7.puzzle_activated = true
		$HorsePedestal8.puzzle_activated = true
		
	# continously check if all pedestals have their correct tag
	if not check2 and $HorsePedestal1.has_correct_tag and $HorsePedestal2.has_correct_tag and $HorsePedestal3.has_correct_tag \
	and $HorsePedestal4.has_correct_tag and $HorsePedestal5.has_correct_tag and $HorsePedestal6.has_correct_tag \
	and $HorsePedestal7.has_correct_tag and $HorsePedestal8.has_correct_tag:
		check2 = true
		
		# show awesome light of completion + drop one of the fuses
		var material = $CarouselLight .get_active_material(0)
		material.albedo_color = Color(0, 1, 0)
		$CarouselLight.set_surface_override_material(0, material)
		$RMFuse1.show()
		
		$HorsePedestal1.puzzle_activated = false
		$HorsePedestal2.puzzle_activated = false
		$HorsePedestal3.puzzle_activated = false
		$HorsePedestal4.puzzle_activated = false
		$HorsePedestal5.puzzle_activated = false
		$HorsePedestal6.puzzle_activated = false
		$HorsePedestal7.puzzle_activated = false
		$HorsePedestal8.puzzle_activated = false
	
