extends Spatial
#Defining variables
var bullet_speed = 1.5
var player_pos 
var bullet_pos
var direction
#Bullet movement code, makes the bullet fire at the height of the player camera and towards the player
func _ready():
	var player_pos = get_parent().get_node("Character").global_transform.origin
	player_pos.y += 1
	var bullet_pos = global_transform.origin
	direction = player_pos - bullet_pos
	direction = direction.normlaized()
	
func _process(delta): 
	translate(direction * bullet_speed * delta)

func _on_Area_body_entered(body): #Makes the bullet disappear if it collides with anything other than the enemy itself
	if body.filename != "res://Enemy.tscn":
		queue_free()
