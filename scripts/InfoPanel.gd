extends StaticBody2D

@export var message: String = ""

func _ready():
	$CanvasLayer/TextureRect/Label.text = message

func _on_CloseArea_area_entered(area):
	if area.is_in_group("Player"):
		$AnimationPlayer.play("panel")

func _on_CloseArea_area_exited(area):
	if area.is_in_group("Player"):
		$AnimationPlayer.play("hide")
