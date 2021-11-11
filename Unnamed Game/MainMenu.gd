extends MarginContainer

const first_scene = preload("res://Level1.tscn")

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector

var current_selection = 0

func ready():
	set_current_selection(0)

func _process(delta):
	if Input.is_action_just_pressed("move_backward") and current_selection < 2:
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("move_foward") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent().add_child(first_scene.instance())
		queue_free()
	elif _current_selection == 1:
		print("Add Options")
	elif _current_selection == 2:
		get_tree().quit()

func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	if current_selection == 0:
		selector_one.text = ">"
		print("1")
	elif current_selection == 1:
		selector_two.text = ">"
		print("2")
	elif current_selection == 2:
		selector_three.text = ">"
		print("3")
