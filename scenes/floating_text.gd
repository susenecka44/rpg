extends Label

@export var float_distance: float = 10.0  
@export var float_duration: float = 0.5  
@export var start_scale: float = 0.5
@export var end_scale: float = 1     

func _ready():
	z_index = 100

	scale = Vector2(start_scale, start_scale)
	modulate.a = 1.0

	start_floating_animation()


func start_floating_animation():
	var tween = get_tree().create_tween()
	
	var target_position_y = position.y - float_distance
	
	tween.tween_property(self, "position:y", target_position_y, float_duration)

	modulate.a = 1.0  
	tween.tween_property(self, "modulate:a", 0.0, float_duration)
	
	scale = Vector2(start_scale, start_scale) 
	tween.tween_property(self, "scale:x", end_scale, float_duration)
	tween.tween_property(self, "scale:y", end_scale, float_duration)
	
	tween.finished.connect(queue_free)
