extends Node
class_name Invincibility

### Invincibility
#attached to the player as a child by PowerUpTrigger.gd. Once created, it adds
#invincibility to the player, and frees itself from memory after its alloted time.

#This script is attached to the root of Scenes/Power Up/Invincibility.tscn, which
#contains all the necessary components to set the drag to 0 for the player
#until the root is freed, causing those nodes to be freed as well.

var player: Bullet
var original_drag: float
const DURATION := 4.0

func _ready():
	var p = get_parent()
	if p is Bullet:
		player = p
		original_drag = player.state.drag
		player.state.drag = 0
		player.state.drag_lock = self
		await get_tree().create_timer(DURATION).timeout
		end_powerup()
	else:
		push_error("This script must be on a child of a Bullet!")
		queue_free()

func end_powerup():
	if player.state.drag_lock == self:
		player.state.drag = original_drag
		player.state.drag_lock = null
	queue_free()
