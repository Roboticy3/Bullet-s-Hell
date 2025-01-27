extends SubViewport

@export var resolution_scale := 0.5

func _ready():
	get_window().size_changed.connect(update_size)
	update_size()
	
func update_size():
	var target_size := get_window().size * resolution_scale
	size = target_size.clamp(Vector2.ONE, get_window().size)
	size_2d_override = get_window().size
	size_2d_override_stretch = true
	#print(size)
