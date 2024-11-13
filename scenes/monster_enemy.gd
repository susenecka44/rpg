extends CharacterBody2D

class_name MonsterEnemy

@export var speed: float = 0.2 
@export var follow_duration: float = 3 
@export var damage_to_player: int = 40

var player_in_range: bool = false
var player_reference: Player = null 
@onready var floating_text:Label = $Label


func _ready() -> void:
	z_index = 8

func _process(delta: float) -> void:
	if player_in_range and player_reference:
		update_tween_position(player_reference.position)
	if GameData.killmonster == true:
		if $HurtTimer:
			$HurtTimer.start()
		floating_text.text = str("- 1000") 
		floating_text.modulate = Color.GREEN
		floating_text.position = position + Vector2(0, -10) 
		floating_text.start_floating_animation()
		
		var timer = Timer.new()
		timer.wait_time = floating_text.float_duration  
		timer.one_shot = true
		timer.connect("timeout", Callable(self, "_on_animation_completed"))
		add_child(timer)
		timer.start()

func _on_animation_completed() -> void:
	queue_free()



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
		get_tree().paused = true
		PhysicsServer2D.set_active(true)
		
		var fishing_game = preload("res://BattleMode/Fishing_minigame.tscn").instantiate()
		get_tree().current_scene.add_child(fishing_game)
