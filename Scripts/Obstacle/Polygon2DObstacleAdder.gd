extends Polygon2D

### Use Polygon2Ds as Obstacles by attaching this script
#Getting materials to look nice on simple-shape areas is fine,
#but once you start making more complex shapes, you basically need
#Polygon2D

#this script can be attached to any Polygon2D to turn it into an
#Obstacle at runtime

#this script is also an example of how to handle an obstacle view
#that can be effected by a damage mask, such obstacles must fire the
#Accessor.obstacle_view_added event to get registered by the damage model
#See DamageModelCanvas for more info.

var obstacle:Obstacle:
	get: return obstacle
var collision_polygon:CollisionPolygon2D:
	get: return collision_polygon
	
@export var params:ObstacleParams

#upate the shape of this Polygon2D
func _set_polygon(new_polygon:PackedVector2Array):
	#clear the existing obstacle underneath if necessary
	if (obstacle != null): remove_child(obstacle)
	
	#create a fresh obstacle and pass the correct parameters so 
	#it behaves as expected
	obstacle = Obstacle.new()
	obstacle.params = params
	
	#create a collision shape for the obstacle based on the new polygon
	collision_polygon = CollisionPolygon2D.new()
	collision_polygon.polygon = new_polygon
	
	#add the collision shape to the obstacle and add it to the scene tree
	obstacle.add_child(collision_polygon)
	add_child(obstacle)
	
	#finally set the new polygon
	polygon = new_polygon

func _ready():
	_set_polygon(polygon)
	
	Accessor.obstacle_view_added.emit(self)
