# broken_pipe.gd

extends Interactable

@export var player : Player
@export var broken_pipe : Node3D
@export var fixed_pipe : Node3D

var fixed : bool = false

func use(_player: Player) -> void:
	if GameManager.current_item == "ReplacementPipe":
		GameManager.current_item = ""
		
		fixed_pipe.visible = true
		broken_pipe.visible = false
		
		$Leak.stop() # Stops the sound of steam leaking from the pipe
		$Label3D.queue_free()
		
