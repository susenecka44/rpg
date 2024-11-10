extends Area2D

@export var amount: int
@export var scale_curve: Curve  # Curve to control scaling over time
@export var scale_duration: float = 2.0  # Duration for a full scaling cycle

var original_scale: Vector2
var time_elapsed: float = 0.0

func _ready():
	original_scale = scale  

func _process(delta: float) -> void:
	if scale_curve:
		time_elapsed = fmod(time_elapsed + delta, scale_duration)
		var scale_factor = scale_curve.sample(time_elapsed / scale_duration)
		scale = original_scale * scale_factor
	else:
		print("scale_curve is not set for this coin")

func _on_other_area_entered(other: Area2D) -> void:
	if other is Player:
		other.collect_coins(amount)
		queue_free()
