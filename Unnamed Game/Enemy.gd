extends KinematicBody

var player 
var follow_player = false 
var move_speed = 100 

func _ready():
	pass
	
func _physics_process(delta):
	if follow_player == true:
		var pos = player.global_transform.origin
		var facing = -global_transform.basis.z
		look_at(pos, Vector3.UP)
		move_and_slide(facing * move_speed * delta, Vector3.UP)

func _on_Area_body_entered(body):
	if body.name == "Character":
		$RayCast.set_enabled(true)
		print("found player")
		follow_player == true
		player = body


func _on_Area_body_exited(body):
	if body.name == "Character":
		$RayCast.set_enabled(false)
		print("lost player")
		follow_player == false
		
