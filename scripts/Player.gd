extends Area2D

class_name Player

@export var speed: float = 5
@export var camera_toshake: Camera2D
signal moved

const TILE_SIZE = 16
const FloatingTextScene = preload("res://scenes/FloatingText.tscn") 

const inputs = {
	"Left": Vector2.LEFT,
	"Right": Vector2.RIGHT,
	"Up": Vector2.UP,
	"Down": Vector2.DOWN
}

var last_dir = Vector2.ZERO
var last_action = ""
var cacti_damage = 10
var knight_damage = 40

func _ready():
	position = GameData.next_location
	$MoveTimer.wait_time = 1.0 / speed  

	if $HurtTimer:
		$HurtTimer.timeout.connect(_on_HurtTimer_timeout)

func _process(delta: float) -> void:
	if GameData.minigame_dammage > 0:
		get_hurt(GameData.minigame_dammage)
		GameData.minigame_dammage = 0


func _unhandled_input(event):
	for action in inputs:
		if event.is_action_pressed(action):
			var dir = inputs[action]
			if move_tile(dir):
				last_action = action
				last_dir = dir
				$MoveTimer.start()

func move_tile(direction: Vector2):
	$RayCast2D.target_position = direction * TILE_SIZE
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		var other = $RayCast2D.get_collider()
		if other.is_in_group("Cacti"):
			get_hurt(cacti_damage)
		return false
	else:
		var target_position = position + direction * TILE_SIZE
		move_with_tween(target_position)
		moved.emit()
		return true
	_align_position()

func _align_position():
	# align position to the middle of a tile
	position.x = int(position.x / TILE_SIZE) * TILE_SIZE
	position.y = int(position.y / TILE_SIZE) * TILE_SIZE
	position += Vector2.ONE * TILE_SIZE/2


func move_with_tween(target_position: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_position, 1.0 / speed)
	tween.set_parallel(true) 

func _on_MoveTimer_timeout():
	if Input.is_action_pressed(last_action):
		if move_tile(last_dir): 
			return
	last_action = ""
	last_dir = Vector2.ZERO
	$MoveTimer.stop()

func get_hurt(value):
	PlayerState.decrease_health(value)
	camera_toshake.shake()
	
	$Sprite2D.modulate = Color(1, 0, 0)  
	if $HurtTimer:
		$HurtTimer.start()

	var floating_text = FloatingTextScene.instantiate()
	floating_text.text = str(value) 
	floating_text.position = position + Vector2(0, -10) 
	get_parent().add_child(floating_text)  
	
	if PlayerState.health == 0:
		die()

func _on_HurtTimer_timeout():
	$Sprite2D.modulate = Color(1, 1, 1)  

func collect_coins(value):
	PlayerState.add_coins(value)
	

func die():
	
	if $HurtTimer:
		$HurtTimer.start()
	var floating_text = FloatingTextScene.instantiate()
	floating_text.text = "YOU DIED - you loose all progress" 
	floating_text.position = position + Vector2(0, -10) 
	get_parent().add_child(floating_text)
	
	await wait(0.5)  
	SceneTransition.death()

	SceneTransition.change_scene_with_fade("res://scenes/World.tscn")
	PlayerState.coins = 0
	PlayerState.health = 100
	HUD.update_coins(PlayerState.coins)
	HUD.update_health(PlayerState.health)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func completed_quests():
	if $HurtTimer:
		$HurtTimer.start()
	var floating_text = FloatingTextScene.instantiate()
	floating_text.text = "YOU COMPLETED ALL QUESTS" 
	floating_text.modulate = 'GREEN'
	floating_text.position = position + Vector2(0, +10) 
	get_parent().add_child(floating_text)
