extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func update_coins(amount: int):
	$Label.text = "Coins: " + str(amount)
	
func update_health(amount: float):
	$ProgressBar.value = amount
