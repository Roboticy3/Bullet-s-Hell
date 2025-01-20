extends Node
class_name SpeedBoost

var speed_record:float
var player:Bullet:
	set(new_player): 
		player = new_player
		speed_record = player.state.speed

const SPEED_BOOST := 500.0

const BOOST_TIME := 4.0

func _ready():
	get_tree().create_timer(BOOST_TIME).timeout.\
		connect(queue_free)

func _physics_process(delta: float) -> void:
	player.state.speed = speed_record + SPEED_BOOST
	
