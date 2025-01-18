extends Polygon2D

### Use Polygon2Ds as Obstacles by attaching this script
#Getting materials to look nice on simple-shape areas is fine,
#but once you start making more complex shapes, you basically need
#Polygon2D

#this script can be attached to any Polygon2D to turn it into an
#Obstacle at runtime

var obstacle:Obstacle:
	get: return obstacle
var collision_polygon:CollisionPolygon2D:
	get: return collision_polygon
	
@export var params := ObstacleParams.new()

func _set_polygon(new_polygon:PackedVector2Array):
	if (obstacle != null): remove_child(obstacle)
	
	obstacle = Obstacle.new()
	collision_polygon = CollisionPolygon2D.new()
	collision_polygon.polygon = new_polygon
	obstacle.add_child(collision_polygon)
	add_child(obstacle)
	
	polygon = new_polygon

func _ready():
	_set_polygon(polygon)
