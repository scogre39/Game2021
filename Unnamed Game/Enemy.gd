extends KinematicBody
#Defining variables
var player
var follow_player = false
var move_speed = 100 
var health = 3
var can_shoot = false
onready var bullet = preload("res://EnemyBullet.tscn") #Preloads the bullet scene

func _ready():
	pass

func _process(delta): #MAkes the enemy disappear when at zero health
	if health <= 0:
		queue_free()

func _physics_process(delta): #Makes the enemy follow the player as well as looking at the player
	if follow_player == true:
		var pos = player.global_transform.origin
		var facing = -global_transform.basis.z
		look_at(pos, Vector3.UP)
		move_and_slide(facing * move_speed * delta, Vector3.UP)
		if $RayCast.get_collider() != null:
			if $RayCast.get_collider().name == "Character":
				move_and_slide(facing * move_speed * delta, Vector3.UP)
		if can_shoot: #Makes the enemy shoot on a timer 
			var new_bullet = bullet.instance()
			new_bullet.global_transform.origin = $Launcher.global_transform.origin
			get_parent().add_child(new_bullet)
			can_shoot = false
			$Timer.start()
		
func _on_Area_body_entered(body): #Makes the enemy follow the player when its inside the area as well as determing if the body is the player
	if body.name == "Character":
		$RayCast.set_enabled(true)
		follow_player = true
		player = body
		can_shoot = true

func _on_Area_body_exited(body):#Stops the enemy follow the player when its outside the area as well as determing if the body is the player
	if body.name == "Character":
		$RayCast.set_enabled(true)
		follow_player = false
		can_shoot = false 


func _on_Timer_timeout():
	can_shoot = true
	pass # Replace with function body.
