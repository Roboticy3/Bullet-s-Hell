extends Area2D

@export_node_path("CanvasItem") var alive_path := NodePath("../Sprite2D")
@onready var alive = get_node_or_null(alive_path)

@export_node_path("CanvasItem") var dead_path := NodePath("../Sprite2D2")
@onready var dead = get_node_or_null(dead_path)

func _ready():
	alive.visible = true
	dead.visible = false
	area_entered.connect(_on_area_entered)

func _on_area_entered(area:Area2D):
	if area is Bullet:
		alive.visible = false
		dead.visible = true
		Accessor.points += 1
