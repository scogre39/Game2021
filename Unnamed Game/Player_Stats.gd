extends Node

var health 
var max_health
var ammo
var max_ammo

func _ready():
	max_health = 100
	health = 100
	max_ammo = 120
	ammo = 120
	
func change_health(amount):
	health += amount 
	health = clamp(health,0, max_health)
	
func change_ammo(amount):
	ammo += amount
	ammo = clamp(ammo,0,max_ammo)
	
func get_health():
	return health 

func get_ammo():
	return ammo
	
func has_ammo():
	return ammo > 0
