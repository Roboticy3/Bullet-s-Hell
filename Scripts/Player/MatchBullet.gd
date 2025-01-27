extends Node2D

var player:Bullet

func _ready():
	if (Accessor.player is Bullet):
		player = Accessor.player
	else:
		Accessor.player_set.connect(func ():
			player = Accessor.player
		)

func _process(delta):
	transform = player.transform
