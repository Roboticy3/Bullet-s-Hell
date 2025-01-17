extends CharacterBody2D

#initial speed in pixels per second
var INITIAL_SPEED := 500
#typical speed loss in pixels per second per second
var SPEED_LOSS := 10

var state := BulletState.new()

func _ready():
	state.speed = INITIAL_SPEED

func _process(delta):
	state.update_movement_axis(Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	))
	
	state.speed -= SPEED_LOSS * delta

func _physics_process(delta: float):
	velocity = state.target_facing * state.speed
	rotation = state.target_facing.angle()
	move_and_slide()
