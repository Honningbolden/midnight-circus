extends Collectible

func _ready():  # when the node is ready
	GameManager.total_items.append("Fuse")


## Add the collectible
func collect():
	if GameManager.current_item == "":
		GameManager.current_item = "Fuse"
		queue_free()  # delete the item
	
