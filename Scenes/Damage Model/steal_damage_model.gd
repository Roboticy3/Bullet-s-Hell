extends CanvasItem

func _ready():
	Accessor.obstacle_view_added.emit(self)
