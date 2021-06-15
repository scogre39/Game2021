extends KinematicBody2D

func _physics_process(delta):
	var moveBy = Vector2(100, 0)
	self.move_and_slide(moveBy, Vector2(0, -1))

	if(is_on_floor()):
		print("On floor")
	else:
		print("Falling")
		move_and_collide(Vector2(0, 5))


