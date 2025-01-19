extends Node

### Singleton to give other nodes in the scene references to points of interest

var player:Bullet:
	set(new_player): 
		player = new_player
		player_set.emit()

signal player_set

signal obstacle_view_added(obstacle_view:CanvasItem)
