extends Node2D

class_name Camera

@export var follow_object: Node2D
@export var follow_speed: float = 5.0
@export var shake_intensity: float = 1.0  
@export var shake_duration: float = 0.3  

func _ready() -> void:
	position = GameData.next_location

func _process(delta: float) -> void:
	if follow_object:
		var target_position = follow_object.position
		
		var distance = target_position.distance_to(position)
		
		if distance < 1.0:
			position = target_position
		else:
			position = position.lerp(target_position, follow_speed * delta)

func shake():
	var tween = create_tween()
	var original_position = position
	var shake_positions = []

	# Generate 10 random shake positions around the original position
	for i in range(10):
		var random_offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		shake_positions.append(original_position + random_offset)

	# Return to the original position at the end of the shake
	shake_positions.append(original_position)

	# Tween through each shake position
	for i in range(shake_positions.size()):
		tween.tween_property(self, "position", shake_positions[i], shake_duration / shake_positions.size())
