# olaf.gd


extends Interactable

@export var key : Node3D


func _ready():
	randomize()


func use(_player: Player) -> void:
	if GameManager.current_item == "Vodka":
		GameManager.current_item = ""  # take away the vodka
		await wait(1)  # wait 1 second
		key.global_position = self.global_position
		key.global_position.x += 1
		# TASK: Add an animation Giving the Vodka to Olaf
		$Keys.play()
		$Snore.stop()
	else:
		var mumbles = [$Mumble1, $Mumble2, $Mumble3]
		
		var idx = randi() % mumbles.size()
		
		for p in mumbles:
			p.stop()
		mumbles[idx].play()
		# TASK: Add a sound effect for when the player doesn't have vodka


## Wait x seconds
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
