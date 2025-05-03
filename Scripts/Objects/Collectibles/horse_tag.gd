extends Collectible

@export var number = 1
@export var color: Color
@onready var TagName = "HorseTag" + str(number)
func _ready():  # when the node is ready
	GameManager.total_items.append(TagName)
	# init color of tag
	$Sprite3D.modulate = color


## Add the collectible
func collect():
	if GameManager.current_item == "":
		GameManager.current_item = TagName
		# probably fix later, instead of queue_free deleting the node send this node to bottom
		# of map as color property of this node are accessed by carousel horse pedestal script
		self.global_position = Vector3(0, -900, 0)
	
