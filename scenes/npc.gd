extends StaticBody2D

@export var recruit_converstation: Array[String]
@export var quest_conversation: Array[String]
@export var completed_coversation: Array[String]

var active: bool = false

var active_quest: bool = false
var finished_quest: bool = false

signal activation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active and Input.is_action_just_pressed("Action"):
		activation.emit()


func _on_close_area_area_entered(area: Area2D) -> void:
	if area is Player:
		$AnimationPlayer.play("panel")
		active = true
		if !active_quest && !finished_quest:
			for text in recruit_converstation:
				$CanvasLayer/TextureRect/Label.text = text
				await activation
			active_quest = true
		elif active_quest && !finished_quest:
			for text in quest_conversation:
				$CanvasLayer/TextureRect/Label.text = text
				await activation
		elif !active_quest && finished_quest:
			for text in completed_coversation:
				$CanvasLayer/TextureRect/Label.text = text
				await activation


func _on_close_area_area_exited(area: Area2D) -> void:
	$AnimationPlayer.play("hide")
