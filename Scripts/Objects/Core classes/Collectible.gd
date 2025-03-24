# files for colelctibles class


extends Node3D
class_name Collectible


func _ready():
	GameManager.total_keys.append(name)


func _collect():
	GameManager.collected_keys.append(name)
	queue_free()
	print(GameManager.collected_keys)
