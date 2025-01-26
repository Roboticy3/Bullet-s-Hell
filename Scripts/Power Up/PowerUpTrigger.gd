extends Area2D

### Give the player a power up
#A "power up" is a scene that is added as a child of the player when they enter
#this area. 

#The power up is then responsible for all of its own behavior. See 
#Scripts/Power Up/SpeedBoost.gd and Scenes/Power Up/speed_boost.tscn.

@export var power_up:PackedScene

#If true, the powerup area will become non-interactive after it finds a player
@export var one_shot := true

func instantiate():
		
	if !(power_up is PackedScene):
		push_error(self, "'s power_up ", power_up, " is not a valid scene!")
		return null
	if ! power_up.can_instantiate():
		push_error(self, "'s power_up ", power_up, " can't be instantiated!")
		return null
	
	return power_up.instantiate()

func _on_area_entered(area:Area2D):
	if area is Bullet:
		add_power_up(area)

signal power_up_added

func add_power_up(to:Bullet):
	var instance := power_up.instantiate()
	to.add_child(instance)
	print("added power up ", instance)
	
	if one_shot:
		set_deferred("monitoring", false)
		set_deferred("monitorable", false)
	
	power_up_added.emit()
