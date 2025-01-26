extends Node

var player:Bullet

const TIME := 4.0

func _ready():
	var p = get_parent()
	if (p is Bullet):
		player = p
	else:
		push_error("This script must be on a child of a Bullet!")
		queue_free()

	player.state.drag_lock = self

	get_tree().create_timer(TIME).timeout.connect(end_powerup)

func end_powerup():
	if player.state.drag_lock == self:
		player.state.drag_lock = null 
	queue_free()
