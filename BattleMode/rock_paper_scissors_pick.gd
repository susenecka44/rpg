extends Node2D

# Enum for selections
enum Pick { NONE, GREEN, RED, YELLOW }

var player_pick = Pick.NONE
var computer_pick = Pick.NONE

@onready var green_picked = $green/GreenPicked
@onready var red_picked = $red/RedPicked
@onready var yellow_picked = $Node2D/YellowPicked

func _ready() -> void:
	$green/Green.connect("input_event", Callable(self, "_on_green_selected"))
	$red/Red.connect("input_event", Callable(self, "_on_red_selected"))
	$Node2D/Yellow.connect("input_event", Callable(self, "_on_yellow_selected"))
	
	reset_picks()

func _on_green_selected(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_click"):
		player_pick = Pick.GREEN
		make_computer_pick()
		show_selection()

func _on_red_selected(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_click"):
		player_pick = Pick.RED
		make_computer_pick()
		show_selection()

func _on_yellow_selected(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_click"):
		player_pick = Pick.YELLOW
		make_computer_pick()
		show_selection()

func make_computer_pick() -> void:
	computer_pick = Pick.values()[randi() % 3 + 1]

func show_selection() -> void:
	reset_picks()
	match player_pick:
		Pick.GREEN:
			green_picked.visible = true
		Pick.RED:
			red_picked.visible = true
		Pick.YELLOW:
			yellow_picked.visible = true

	# Show results
	var result_text = determine_winner()
	print(result_text)  

func reset_picks() -> void:
	green_picked.visible = false
	red_picked.visible = false
	yellow_picked.visible = false

func determine_winner() -> String:
	if player_pick == computer_pick:
		return "It's a tie!"
	
	if (player_pick == Pick.GREEN and computer_pick == Pick.RED) or \
	   (player_pick == Pick.RED and computer_pick == Pick.YELLOW) or \
	   (player_pick == Pick.YELLOW and computer_pick == Pick.GREEN):
		return "Computer wins!"
	else:
		return "You win!"
