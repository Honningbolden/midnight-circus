# steam_engine.gd

extends Interactable


@export var valve : MeshInstance3D
@export var broken_pipe : Node3D
@export var door : Node3D
@export var player : Player

var fixed : bool = false


func use(_player: Player) -> void:
	if not fixed and GameManager.current_item == "Valve":
		$IdleSound.play()
		valve.visible = true
		var tween = create_tween()
		tween.tween_property(valve, "rotation_degrees", Vector3(90,0,0), 1)
		if GameManager.current_item == "Valve":
			GameManager.current_item = ""
		fixed = true
		
		if broken_pipe.fixed:
			door.use(player)
