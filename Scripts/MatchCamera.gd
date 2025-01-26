extends Node

var player:Bullet
var camera:Camera2D

func _ready():
	if (Accessor.player is Bullet):
		update_player()
	Accessor.player_set.connect(update_player)

func update_player():
	player = Accessor.player
	camera = player.camera

func _process(delta):
	if (camera is Camera2D):
		self.global_transform = camera.global_transform
		self.ignore_rotation = camera.ignore_rotation
		
