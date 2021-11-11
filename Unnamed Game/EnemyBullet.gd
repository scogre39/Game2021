extends Spatial

var bullet_speed = 1.5
var player_pos 
var bullet_pos
var direction

func _ready():
	var player_pos = get_parent().get_node("Character").global_transform.origin
	player_pos.y += 1
	var bullet_pos = global_transform.origin
	direction = player_pos - bullet_pos
	#direction = direction.normlaized()
	
func _process(delta):
	translate(direction * bullet_speed * delta)

func _on_Area_body_entered(body):
	if body.filename != "res://Enemy.tscn":
		queue_free()
