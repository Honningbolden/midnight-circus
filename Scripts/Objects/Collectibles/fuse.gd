extends Collectible

func _ready():  # when the node is ready
	GameManager.total_items.append("Fuse")


## Add the collectible
func collect():
	GameManager.collected_items.append("Fuse")
	queue_free()  # delete the item
	
