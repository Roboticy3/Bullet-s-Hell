extends Area2D

@export var strength := 300.0
@export var turn_strength := 10.0

@export var alignment_bias := 0.7

func _physics_process(delta: float) -> void:
	var wind_vector := global_transform.x.normalized()
	for area in get_overlapping_areas():
		if area is Bullet:
			var axis:Vector2 = area.state.movement_axis.normalized()
			var angle := axis.angle_to(wind_vector)
			area.state.turn_movement_axis(angle * turn_strength * delta)
			var alignment := axis.dot(wind_vector) - alignment_bias
			area.state.update_speed(
				-(alignment) * strength * delta, area.INITIAL_SPEED
			)
	
