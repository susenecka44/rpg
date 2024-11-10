extends Area2D

@export var amount: int


func _on_other_area_entered(other: Area2D) -> void:
	if other is Player:
		other.collect_coins(amount)
		queue_free()
