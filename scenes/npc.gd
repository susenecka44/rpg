extends StaticBody2D

@export var converstation: Array[String]
var active: bool = false

signal activation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active and Input.is_action_just_pressed("Action"):
		activation.emit()
