extends CharacterBody2D

#this key lets other scripts reference behavior of this script, like it's
#state. Godot's registration for classes is iffy, so I try not to
#use this feature too much
class_name Bullet

#initial speed in pixels per second
var INITIAL_SPEED := 1000.0

#typical speed loss in pixels per second squared
var SPEED_LOSS := 10.0

#speed at which the player will start to die, not yet implemented
var CRITICAL_SPEED := 100.0

#the rate at which the velocity will move towards the target velocity when 
#turning in pixels per second squared
var STEERING_FACTOR := 5.0

var state := BulletState.new()

func _ready():
	state.speed = INITIAL_SPEED

func _process(delta):
	state.update_movement_axis(Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	))

func _physics_process(delta: float):
	state.update_speed(-SPEED_LOSS * delta)
	state.update_velocity(
		state.movement_axis.normalized(), 
		STEERING_FACTOR * delta
	)
	
	velocity = state.velocity
	rotation = state.velocity.angle()
	
	move_and_slide()
