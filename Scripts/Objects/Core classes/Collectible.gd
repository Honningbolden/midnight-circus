# Collectible Class


extends Node3D
class_name Collectible


func _ready():  # when the node is ready
	GameManager.total_items.append(name)


## Add the collectible
func collect():
	GameManager.collected_items.append(name)
	queue_free()  # delete the item
