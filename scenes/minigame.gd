extends TextureButton


var number: int = 0

signal tile_pressed
signal slide_completed

func set_text(new_num): 
	number = new_num
	$number/Label.text = str(number)

func set_sprite(new_frame, size, tile_size):
	var sprite = $Monster130
	update_size(size, tile_size)
	
	sprite.set_hframes(size)
	sprite.set_vframes(size)
	sprite.set_frame(size)
	
func update_size(size, tile_size):
	var new_size = Vector2(tile_size, tile_size)
	set_size(new_size)
	$number.set_size(new_size)
	$number/ColorRect.set_size(new_size)
	$number/Label.set_size(new_size)
	
func set_sprite_texture(texture):
	$Monster130.set_texture(texture)

func slide_to(new_position, duration):
	var tween = get_tree().create_tween()
	tween.interpolate_property(self, "rect_position", null, new_position, duration, Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	
func set_number_visible(state):
	$number.visible =  state

func _on_tile_pressed() -> void:
	emit_signal("tile_pressed", number)

func _on_tween_tween_completed(object, key):
	emit_signal("slide_completed", number)
