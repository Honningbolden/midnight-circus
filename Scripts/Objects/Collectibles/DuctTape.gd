extends Collectible

func _ready():  # when the node is ready
	GameManager.total_items.append("Duct Tape")


## Add the collectible
func collect():
	GameManager.collected_items.append("Duct Tape")
	queue_free()  # delete the item
