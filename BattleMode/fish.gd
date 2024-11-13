extends CharacterBody2D

@export var aquaContainer: Control
@onready var fish_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 200.0  
var targetPosition: Vector2
var borderDistance := 10

func _ready() -> void:
	randomize()
	_set_target_position()

func _set_target_position() -> void:
	await get_tree().physics_frame
	_set_new_target_position()

func _set_new_target_position() -> void:
	var boxSize := aquaContainer.get_global_rect()
	
	var xPosition := int(randi_range(
		boxSize.position.x + borderDistance, boxSize.position.x + boxSize.size.x - borderDistance
	))
	var yPosition := int(randi_range(
		boxSize.position.y + borderDistance, boxSize.position.y + boxSize.size.y - borderDistance
	))
	
	targetPosition = Vector2(xPosition, yPosition)

func _physics_process(delta: float) -> void:
	if not targetPosition: return

	var direction := (targetPosition - global_position).normalized()
	if direction.length() > 0.1:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	global_position += velocity * delta 

	if global_position.distance_to(targetPosition) < 5:
		_on_target()


func _on_target() -> void:
	set_physics_process(false)
	await get_tree().create_timer(1.5).timeout
	_set_new_target_position()
	set_physics_process(true)
