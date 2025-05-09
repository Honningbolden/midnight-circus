extends Collectible

@export var number = 1
@export var color: Color
@onready var TagName = "HorseTag" + str(number)


func _ready():  # when the node is ready
	GameManager.total_items.append(TagName)
	# init color of tag
	$Sprite3D.modulate = color
