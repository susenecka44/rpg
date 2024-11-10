extends Area2D

@export var next_scene: String = "res://scenes/House.tscn"
@export var message: String = "Press SPACE to enter."
@export var next_location: Vector2

var is_active = false

func _ready():
	$CanvasLayer/TextureRect/Label.text = message

func _unhandled_input(event):
	if event.is_action_pressed("Action") and is_active:
		GameData.next_location = next_location
		SceneTransition.change_scene_with_fade(next_scene)

func _on_Teleport_area_entered(area):
	if area.is_in_group("Player"):
		$AnimationPlayer.play("panel")
		is_active = true

func _on_Teleport_area_exited(area):
	if area.is_in_group("Player"):
		$AnimationPlayer.play("hide")
		is_active = false
