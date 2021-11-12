extends Control

func _ready():
	$HealthBar.max_value = PlayerStats.health_max #Sets the health bar to full
	
func _process(delta):
	$HealthBar.value = PlayerStats.health #Makes the health bar the same value as the health
	$AmmoCount.text = "X " + PlayerStats.get_ammo() #Makes the ammo counter the same value as the ammo
