extends Node

@onready var debris = $Debris
@onready var fire = $Fire
@onready var smoke = $Smoke

func explode():
	debris.emitting = true
	fire.emitting = true
	smoke.emitting = true
	await get_tree().create_timer(2.0).timeout
	queue_free()
