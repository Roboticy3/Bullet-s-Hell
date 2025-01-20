extends Area2D

#this key lets other scripts reference behavior of this script, like it's
#state. Godot's registration for classes is iffy, so I try not to
#use this feature too much
class_name Bullet

@export var open_air_properties := ObstacleParams.new()

var INITIAL_SPEED := 1000.0

#speed at which the player will start to die, not yet implemented
var CRITICAL_SPEED := 100.0

#the rate at which the velocity will move towards the target velocity when 
#turning in pixels per second squared
var STEERING_FACTOR := 5.0

var state := BulletState.new()

@export_node_path("Camera2D") var camera_path := NodePath("Camera2D")
@onready var camera:Camera2D = get_node_or_null(camera_path)

func _ready():
	Accessor.player = self
	state.speed = INITIAL_SPEED
	
	state.update_movement_axis(Vector2.RIGHT)

func _physics_process(delta: float):
	
	state.update_drag(open_air_properties, get_overlapping_areas())
	state.update_speed(delta, INITIAL_SPEED)
	state.update_velocity(
		state.movement_axis, 
		STEERING_FACTOR * delta
	)
	
	position += state.velocity * delta
	rotation = state.velocity.angle()

#while BulletState handles the drag while inside of obstacles,
#its more convenient to handle the actual entering and exiting here
func _on_area_entered(area: Area2D) -> void:
	if (area is Obstacle):
		#print("entered ", area)
		state.speed -= area.params.entry_penalty

func _on_area_exited(area: Area2D) -> void:
	if (area is Obstacle):
		state.speed -= area.params.exit_penalty
