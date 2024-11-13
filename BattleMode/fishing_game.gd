extends Control

@onready var catch_bar: ProgressBar = %CatchBar
var fishing_game = "res://BattleMode/Fishing_minigame.tscn"
var onCatch := false
var catchSpeed = 0.3
var catchingValue = 50.0

func _physics_process(delta: float) -> void:
	if onCatch:
		catchingValue += catchSpeed
	else:
		catchingValue -= catchSpeed
	
	if catchingValue < 0.0: 
		catchingValue = 0
		GameData.minigame_dammage = 30
		_quit_game()

	elif catchingValue >= 100.0:
		GameData.killmonster = true
		_quit_game()

	catch_bar.value = catchingValue

func _quit_game() -> void:
	GameData.minigame_end = true
	fishing_game.queue_free()  
		
func _process(delta: float) -> void:
	pass

func _game_end() -> void:
	var tween = get_tree().create_tween()
	
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "global_position", global_position + Vector2(0, 500), 0.5)

func _on_target_target_entered() -> void:
	onCatch = true

func _on_target_target_exited() -> void:
	onCatch = false

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
