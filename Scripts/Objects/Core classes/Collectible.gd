# Collectible Class


extends Node3D
class_name Collectible


func _ready():  # when the node is ready
	GameManager.total_items.append(name)

## Add the collectible
func collect():
	if GameManager.current_item == "":
		GameManager.pickup(name)
		await wait(0.01)
		queue_free()  # delete the item

func wait(seconds: float) -> void:        # Thanks to GBWD on the Godot forum
	await get_tree().create_timer(seconds).timeout
