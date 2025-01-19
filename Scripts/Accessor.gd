extends Node

### Singleton to give other nodes in the scene references to points of interest
#These points of interest only work as expected if there should only be *one*
#of them, and objects referencing them listen for the signals that fire when 
#they are updated

var player:Bullet:
	set(new_player): 
		player = new_player
		player_set.emit()

signal player_set

var damage_model_viewport:SubViewport:
	set(new_damage_model_viewport):
		damage_model_viewport = new_damage_model_viewport
		damage_model_viewport_set.emit()
	
signal damage_model_viewport_set
