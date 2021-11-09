extends KinematicBody

var Character
var follow_Character = false 
var move_speed = 100 
var health = 3

func _ready():
	pass
	
func _process(delta):
	if health <= 0:
		queue_free()
	
func _physics_process(delta):
	if follow_Character == true:
		var pos = Character.global_transform.origin
		var facing = -global_transform.basis.z
		look_at(pos, Vector3.UP)
		if $RayCast.get_collider() != null:
			if $RayCast.get_collider().name == "Character":
				move_and_slide(facing * move_speed * delta, Vector3.UP)

func _on_Area_body_entered(body):
	if body.name == "Character":
		$RayCast.set_enabled(true)
		print("found player")
		follow_Character == true
		Character = body
		


func _on_Area_body_exited(body):
	if body.name == "Character":
		$RayCast.set_enabled(false)
		print("lost player")
		follow_Character == false
		
