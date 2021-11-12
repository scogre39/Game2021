extends KinematicBody

const end_screen = preload("res://EndScreen.tscn")#PReloading the end screen so when the player dies the end screen appears 
#Defining variables
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

#Defing node chains into simpler names
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
	elif Input.is_action_just_pressed("fire") and PlayerStats.ammo > 0: #Shooting code, with enemy code the enemy disappears atfer enough damage
		PlayerStats.change_ammo(-1)
		if aimcast.is_colliding():
			var target = aimcast.get_collider()
			if target.is_in_group("Enemy"):
				print("hit enemy")
				target.health -= 1
	if Input.is_action_just_pressed("ui_cancel"): #Basic movement + escape to make the mouse visable again
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
	if PlayerStats.get_health() <= 0: #Thos code checks to see if the player health is a zero and if so plays the end screen scene
		get_parent().add_child(end_screen.instance())

func _on_Area_area_entered(area): #The damage from enemy when the enemy bullet collides with the player
	if area.get_parent().filename == "res://EnemyBullet.tscn":
		PlayerStats.change_health(-1)
		area.get_parent().queue_free()


func _on_Area_body_entered(body): #The damage from the enemy when the player collides with an enemy
	if (body.filename == "res://Enemy.tscn") and $InvulnerabilityFrames.is_stopped():
		$InvulnerabilityFrames.start()
		PlayerStats.change_health(-2)
