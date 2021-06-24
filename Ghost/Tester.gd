extends KinematicBody

var speed = 7
var acceleration = 20
var gravity = 5
var jump_power = 75
var falling = Vector3() 

var damage = 100

var mouse_sensitivity = 0.5

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

onready var head = $Head 
onready var aimcast = $Head/Camera/AimCast
onready var floor_ray = $FloorRay
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _physics_process(_delta):
	
	direction = Vector3()
	var is_grounded = floor_ray.is_colliding()
	if Input.is_action_just_pressed("jump") and is_grounded:
		velocity.y = jump_power
	velocity = move_and_slide(velocity, Vector3.UP)
	
func _process(delta):		
	if Input.is_action_just_pressed("fire"):
		if aimcast.is_colliding():
			var target = aimcast.get_collider()
			if target.is_in_group("Enemy"):
				print("Hit Enemy")
				target.health -= damage
		
	
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
	velocity = velocity + direction
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y -= gravity
	print(velocity)
	velocity = move_and_slide(velocity, Vector3.UP)
	move_and_slide(velocity, Vector3.UP)
	
