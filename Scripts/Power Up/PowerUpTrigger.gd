extends Area2D

### Give the player a speed boost
#Power ups inherit Area2D. When they enter another area, they check if that area
#is the player.

#In the case of the speed boost, we need to increase the player's speed, then,
#after a set amount of time, "remove" the boost.

@export var power_up:PackedScene

@export var player_target_prop := "player"

func _on_area_entered(area:Area2D):
	
	if !(power_up is PackedScene):
		push_error(self, "'s power_up ", power_up, " is not a valid scene!")
		return
	if ! power_up.can_instantiate():
		push_error(self, "'s power_up ", power_up, " can't be instantiated!")
		return
	
	
	if area is Bullet:
		var instance := power_up.instantiate()
		instance.set(player_target_prop, area)
		area.add_child(instance)
