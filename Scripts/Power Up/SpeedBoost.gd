extends Node
class_name SpeedBoost

### A Speed Boost
#attached to the player as a child by PowerUpTrigger.gd. Once created, it adds
#speed to the player, and frees itself from memory after its alloted time.

#This script is attached to the root of Scenes/Power Up/speed_boost.tscn, which
#contains all the necessary components to draw a speed trail behind the player
#until the root is freed, causing those nodes to be freed as well.

var speed_record:float
var player:Bullet

const SPEED_BOOST := 2000.0

const BOOST_TIME := 4.0

var timer:SceneTreeTimer

func _ready():
	#reference the player as this node's parent
	player = get_parent()
	if !(player is Bullet):
		queue_free()
		return
	speed_record = player.state.speed
	
	timer = get_tree().create_timer(BOOST_TIME)
	
	timer.timeout.connect(queue_free) #when the time runs out, destroy this boost
	
	#apply the speed boost
	player.state.speed = SPEED_BOOST

#if the player gets too slow, end the speed boost early
func _physics_process(delta: float) -> void:
	if (player.state.speed < speed_record):
		end_boost()

#to end the boost early, disconnect the timer and set self to be freed early
func end_boost():
	if (timer is SceneTreeTimer): timer.timeout.disconnect(queue_free)
	queue_free()
