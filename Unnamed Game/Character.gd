extends KinematicBody

var speed = 7
var acceleration = 20
var gravity = 15
var jump_power = 175
var falling = Vector3() 

var damage = 1

var mouse_sensitivity = 0.05

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

onready var head = $Head 
onready var aimcast = $Head/Camera/AimCast
onready var floorray = $FloorRay

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#This makes the head follow the mouse movement
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

#Jump code using both gravity to pull down and jump power to go up
func _physics_process(delta):
	direction = Vector3()
	velocity.y -= gravity
	if Input.is_action_just_pressed("jump") and floorray.is_colliding():
		velocity.y += jump_power
	velocity = move_and_slide(velocity, Vector3.UP)
	
	#SHooting code, paired with the enemy code the enemy will disapear when hit enough times	
	if Input.is_action_just_pressed("fire") and PlayerStats.has_ammo() > 0:
		PlayerStats.change_ammo(-1)
		if aimcast.is_colliding():
			var target = aimcast.get_collider()
			if target.is_in_group("Enemy"):
				print("Hit Enemy")
				target.health -= damage
		
	#Basic movement + escape to make the mouse visable again
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("move_foward"):
		direction -= transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x
		
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity = move_and_slide(direction * speed, Vector3.UP)
	move_and_slide(velocity, Vector3.UP)
