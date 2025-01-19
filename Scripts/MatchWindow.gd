extends SubViewport

func _ready():
	get_window().size_changed.connect(update_size)
	update_size()
	
func update_size():
	size = get_window().size
	#print(size)
