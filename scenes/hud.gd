extends CanvasLayer

@export var health_tween_duration: float = 0.3 
@export var damage_color: Color = Color.DARK_RED  

var current_coins: int = 0  

func update_coins(amount: int):
	var tween = get_tree().create_tween()
	tween.tween_method(Callable(self, "_update_coin_label"), current_coins, amount, 0.5)

func _update_coin_label(value: int):
	$Label.text = "Coins: " + str(value)

func update_health(amount: float):
	var health_bar = $ProgressBar
	var damage_bar = $ProgressBar2

	health_bar.value = amount

	var damage_style = StyleBoxFlat.new()
	damage_style.bg_color = damage_color
	damage_bar.set("custom_styles/fg", damage_style)  

	var tween = get_tree().create_tween()
	tween.tween_property(damage_bar, "value", amount, health_tween_duration)

	tween.finished.connect(func() -> void:
		_on_tween_completed()
	)

func _on_tween_completed():
	var default_style = StyleBoxFlat.new()
	$ProgressBar2.set("custom_styles/fg", default_style)
