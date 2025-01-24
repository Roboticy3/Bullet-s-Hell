extends Object
class_name BulletState

#state wrapper for the player

###INPUT HANDLING
#turn_movement_axis rotates movement_axis by a specified angle, which is used
#to compute the movement direction of the player

var movement_axis := Vector2.RIGHT

#last_movement_axis is good for quickly detecting changes in direction before
#they are necessarily applied to the player
var last_movement_axis := Vector2.RIGHT

func turn_movement_axis(amount:float):
	last_movement_axis = movement_axis
	movement_axis = movement_axis.rotated(amount)

###VELOCITY HANDLING
#update_velocity applies changes in direction to velocity, over time, and is
#meant to be called every physics step

#a record of the player's velocity
#this isn't strictly the player's actual velocity, but it's meant to be passed
#to a character controller on each physics step. If the player slides along a 
#wall or hits something, the "real" velocity won't match.
var velocity := Vector2.ZERO

#a record of the player's speed
#used to help compute velocity, which should approach a magnitude equivalent
#to this value
var speed := 0.0

#drag that's applied always
#not technically physical drag, 
#since it doesn't take current velocity into account
var drag := 0.0
#drag that can be applied while turning
var drag_turning_factor := 0.0

func update_velocity(to:Vector2, steer:float) -> Vector2:
	if (to.is_zero_approx()): return Vector2.ZERO
	var target_velocity := to.normalized() * speed
	var steering_vector := target_velocity - velocity
	speed -= drag_turning_factor * absf(velocity.angle_to_point(target_velocity))
	velocity += steering_vector * steer
	return steering_vector

func update_speed(delta:float, max_speed:float):
	var drag_speed := speed / max_speed
	speed -= drag * drag_speed * drag_speed * delta
	speed = max(speed, 0.0)

#the player could be under any number of areas, in this case, sum their drags together
#this lets us do sort of "layered materials" for extra-intimidating fortresses, 
#and stops the game from crashing if two blocks share a pixel, which is nice
func update_drag(open_air_properties:ObstacleParams, overlapping_areas:Array[Area2D]):
	drag = open_air_properties.drag
	drag_turning_factor = open_air_properties.drag_turning_factor
	for o in overlapping_areas:
		if o is Obstacle:
			drag += o.params.drag
			drag_turning_factor += o.params.drag_turning_factor

### DISPLAY
#code copied from another project
#the nice thing about what I affectionately refer to as the "hood state pattern"
#is that by implementing Godot's _to_string() function, you get a pretty quick
#and easy debug display, that's also easy to turn off for production\

#the contents of _to_string() are meant to be passed to a RichTextLabel Node,
#so the color tags get interpreted and displayed correctly

func draw_flag(x:bool) -> String:
	return "[color=" + ("green" if x else "red") + "]" + str(x) + "[/color]"

func draw_float(x:float) -> String:
	var color := "yellow"
	var d := signf(x)
	if (d == 1):
		color = "green"
	elif (d == -1):
		color = "red"
	return "[color=" + color + "]" + str(x) + "[/color]"

func _to_string():
	return \
	"PHYSICAL:\n" + \
		"\t velocity: (" + draw_float(velocity.x) + ", " + draw_float(velocity.y) + ")\n" + \
		"\t speed: " + draw_float(speed) + "\n" + \
		"\t drag: " + draw_float(drag) + "\n" + \
		"\t drag turning factor: " + draw_float(drag_turning_factor) + "\n" + \
	"INPUT BASED:\n" + \
		"\t movement axis: (" + draw_float(movement_axis.x) + ", " + draw_float(movement_axis.y) + ")\n"
