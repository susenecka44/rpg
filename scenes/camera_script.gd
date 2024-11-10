extends Node2D

@export var follow_object: Node2D
@export var follow_speed: float = 5.0 

func _process(delta: float) -> void:
	if follow_object:
		var target_position = follow_object.position
		
		var distance = target_position.distance_to(position)
		
		if distance < 1.0:
			position = target_position
		else:
			position = position.lerp(target_position, follow_speed * delta)
