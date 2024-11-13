extends CharacterBody2D

class_name MonsterEnemy

@export var speed: float = 0.2 
@export var follow_duration: float = 3 
@export var damage_to_player: int = 40

var player_in_range: bool = false
var player_reference: Player = null 

func _ready() -> void:
	z_index = 8

func _process(delta: float) -> void:
	if player_in_range and player_reference:
		update_tween_position(player_reference.position)

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area is Player:
		player_in_range = true
		player_reference = area as Player  

func _on_detection_area_area_exited(area: Area2D) -> void:
	if area is Player:
		player_in_range = false
		player_reference = null 
		stop_following()

func update_tween_position(target_position: Vector2) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_position, follow_duration)

func stop_following() -> void:
	var tween = get_tree().create_tween()
	tween.kill()

func _on_dammage_area_area_entered(area: Area2D) -> void:
	if area is Player:
		SceneTransition.change_scene_with_fade("res://scenes/CombatScene.tscn")
