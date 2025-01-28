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

#Read the damage texture to find blue pixels.
#Blue pixels will be left by the player's "immediate" shadow, a bullet-shaped
#sprite directly beneath them at all times in the damage model.
#If no blue pixels are read, don't punish the player for being inside of an
#obstacle.
#Since the damage model uses additive mixing, the Blue shadow of the player is
#"blended" with the regular damage path. Therefore, only "true" Blue displays 
#where the player is not intersecting with the damage model.
#Therefore, if the damage model contains blue, the player is not fully contained
#within their previous path of destruction. 
#The effect is that of being able to cleanly pass through obstacles you've
#dug through before. Think of invincibility power up + cinderblock wall where
#the player has to dig through, then go back.
@export_node_path("TextureHasColor") \
	var texture_reader_path := NodePath("TextureHasColor")
@onready \
	var texture_reader:TextureHasColor = get_node_or_null(texture_reader_path)

func _ready():
	Accessor.player = self
	state.speed = INITIAL_SPEED

func _physics_process(delta: float):
	
	#thanks to stacked drag, open air drag, and texture reading, the drag
	#calculation is a little... involved.
	state.update_drag(
		open_air_properties, 
		get_overlapping_areas(), 
		texture_reader
	) 
	state.update_speed(delta, INITIAL_SPEED)
	state.update_velocity(
		state.movement_axis, 
		STEERING_FACTOR * delta
	)
	
	position += state.velocity * delta
	rotation = state.velocity.angle()
