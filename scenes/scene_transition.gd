extends Node2D

class_name SceneTransitionScript

func change_scene_with_fade(next_scene: String):
	print("fading")
	$AnimationPlayer.play("fadeout")
	await $AnimationPlayer.animation_finished
	print("faded")
	get_tree().change_scene_to_file(next_scene)
	$AnimationPlayer.play("fadein")

func death():
	$AnimationPlayer.play("fadeout")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("fadein")

func _ready() -> void:
	$AnimationPlayer.play("fadein")
	await  $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/World.tscn")
