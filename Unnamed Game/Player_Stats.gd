extends Node
#Defining variables
var health 
var health_max
var ammo
var ammo_max

func _ready():
	health_max = 20
	health = 20
	ammo_max = 120
	ammo = 120
	
func change_health(amount): #Making the health change 
	health += amount 
	health = clamp(health,0, health_max)
	
func change_ammo(amount):#Making the ammo change 
	ammo += amount
	ammo = clamp(ammo,0,ammo_max)
	
func get_health(): #Gives a health value
	return (health) 

func get_ammo(): #Gives an ammo value
	return str(ammo)
	
func has_ammo(): #Determines whether the player has ammo or not
	return ammo > 0
