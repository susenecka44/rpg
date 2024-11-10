extends StaticBody2D

@export var converstation: Array[String]
var active: bool = false

signal activation

func _ready() -> void:
	$CanvasLayer/TextureRect.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active and Input.is_action_just_pressed("Action"):
		activation.emit()


func _on_close_area_area_entered(area: Area2D) -> void:
	if area is Player:
		$CanvasLayer/TextureRect.show()
		active = true
		
		for text in converstation:
			$CanvasLayer/TextureRect/Label.text = text
			await activation


func _on_close_area_area_exited(area: Area2D) -> void:
	$CanvasLayer/TextureRect.hide()
