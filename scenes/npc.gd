extends StaticBody2D

@export var recruit_converstation: Array[String]
@export var quest_conversation: Array[String]
@export var completed_coversation: Array[String]
@export var quest: int


@onready var text_label : Label = $Label
# 0 = sellout, chce 20 goldu
# 1 = combat clovek, chce zabit priserky

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
		if quest == 0:
			_check_completion_0()
		elif quest == 1:
			_check_completion_1()
		
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
	if GameData.finished_quests >= 2:
		var player = area as Player
		player.completed_quests()


func _on_close_area_area_exited(area: Area2D) -> void:
	$AnimationPlayer.play("hide")


func _check_completion_0():
	if PlayerState.coins >= 20:
		finished_quest = true
		active_quest = false
		GameData.finished_quests +=1
		
func _check_completion_1():
	if GameData.killmonster == true:
		GameData.finished_quests +=1
		finished_quest = true
		active_quest = false
