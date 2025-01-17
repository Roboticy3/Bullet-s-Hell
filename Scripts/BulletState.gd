extends Node
class_name BulletState

#state wrapper for the player

var movement_axis := Vector2.ZERO
var last_movement_axis := Vector2.ZERO

var target_facing := Vector2.ZERO

func update_movement_axis(to:Vector2):
	last_movement_axis = movement_axis
	movement_axis = to
	
	if (!to.is_zero_approx()):
		target_facing = to.normalized()

var speed := 0.0
