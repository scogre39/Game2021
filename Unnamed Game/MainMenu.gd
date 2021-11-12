extends MarginContainer

const first_scene = preload("res://Level1.tscn") #Preloading the first level scene 

#Defining node paths as simplier variables
onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector

var current_selection = 0

func ready():
	set_current_selection(0)#Settibng the current selection value to zero at the begining 
	print("0") #CHecking to see if the intial value is 0

func _process(delta):
	if Input.is_action_just_pressed("move_backward") and current_selection < 2:
		current_selection += 1#Moves the > down between the different options
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("move_foward") and current_selection > 0:
		current_selection -= 1#Moves the > up between the different options
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection) #When enter is pressed runs the handle selection coed below 

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent().add_child(first_scene.instance())
		queue_free() #Opens the first scene/level 1
	elif _current_selection == 1:
		print("Add Options")
	elif _current_selection == 2:
		get_tree().quit() #Closes the game window 

func set_current_selection(_current_selection):
	selector_one.text = "" #Setting each text to empty the changing the text to > when the current selction is equal to each different selector
	selector_two.text = ""
	selector_three.text = ""
	if current_selection == 0:
		selector_one.text = ">"
		print("1")#Testing to see if the current value is 1
	elif current_selection == 1:
		selector_two.text = ">"
		print("2")#Testing to see if the current value is 2
	elif current_selection == 2:
		selector_three.text = ">"
		print("3")#Testing to see if the current value is 3
