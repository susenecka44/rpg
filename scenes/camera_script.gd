extends Node2D

@export var follow_object: Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = follow_object.position