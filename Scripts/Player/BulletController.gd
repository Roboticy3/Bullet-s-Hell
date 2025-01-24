extends Node

class_name BulletController

enum CONTROL_MODE {
	STICK,
	STEER,
	STEER_VERTICAL,
	MOUSE
}

@export var control_mode := CONTROL_MODE.MOUSE
var control_function:Callable

@export var steering_sensitivity := 5.0

var player:Bullet

func _ready():
	if Accessor.player is Bullet:
		enable()
	else:
		set_process(false)
	Accessor.player_set.connect(enable)

func enable():
	player = Accessor.player
	set_process(true)
	update_control_mode(control_mode)
	Accessor.player_controller = self

func _process(delta):
	control_function.call(delta)

func update_control_mode(new_control_mode:CONTROL_MODE):
	control_mode = new_control_mode
	if player is Bullet: match control_mode:
		CONTROL_MODE.STICK:
			player.camera.ignore_rotation = true
			player.camera.rotation = .0
			control_function = control_stick
		CONTROL_MODE.STEER:
			player.camera.ignore_rotation = false
			player.camera.rotation = .0
			control_function = control_steer
		CONTROL_MODE.STEER_VERTICAL:
			player.camera.ignore_rotation = false
			player.camera.rotation = PI * .5
			control_function = control_steer_vertical
		CONTROL_MODE.MOUSE:
			player.camera.ignore_rotation = true
			player.camera.rotation = .0
			control_function = control_mouse

func control_stick(delta:float):
	player.state.update_movement_axis(Vector2(
		Input.get_axis("stick_left", "stick_right"),
		Input.get_axis("stick_up", "stick_down")
	))

func control_steer(delta:float):
	player.state.turn_movement_axis(
		Input.get_axis("stick_up", "stick_down") * delta * steering_sensitivity
	)

func control_steer_vertical(delta:float):
	player.state.turn_movement_axis(
		Input.get_axis("stick_left", "stick_right") * delta * steering_sensitivity
	)

func control_mouse(delta:float):
	#get_global... is a built-in function for "CanvasItem" Nodes, which all
	#Node2D inherit. Since Bullet inherits Area2D, we can call it from player to
	#get the current mouse position
	var mouse_position := player.get_global_mouse_position() 
	var target_vector := mouse_position - player.position
	
	player.state.update_movement_axis(target_vector)
