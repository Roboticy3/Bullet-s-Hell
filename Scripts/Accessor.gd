extends Node

### Singleton to give other nodes in the scene references to points of interest
#These points of interest only work as expected if there should only be *one*
#of them, and objects referencing them listen for the signals that fire when 
#they are updated

var player:Bullet:
	set(new_player): 
		player = new_player
		player_set.emit()

var points := 0:
	get(): return points
	set(new_points):
		points = new_points
		if points >= 16:
			# Remove the current level
			var level = get_tree().root.get_node("Test2")
			get_tree().root.remove_child(level)
			level.call_deferred("free")

			# Add the next level
			var next_level_resource = load("res://Scenes/Win.tscn")
			var next_level = next_level_resource.instantiate()
			get_tree().root.add_child(next_level)

signal player_set

var player_controller:BulletController:
	set(new_player_controller): 
		player_controller = new_player_controller
		player_controller_set.emit()

signal player_controller_set

var damage_model_viewport:SubViewport:
	set(new_damage_model_viewport):
		damage_model_viewport = new_damage_model_viewport
		damage_model_viewport_set.emit()
	
signal damage_model_viewport_set
