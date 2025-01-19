extends Resource
class_name ObstacleParams

#values subtracted from player's speed on entry and exit
@export var entry_penalty := 0.0
@export var exit_penalty := 0.0

#values added to player's drag while inside
@export var drag := 10.0
@export var drag_turning_factor := 1.0
