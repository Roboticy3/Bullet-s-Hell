extends CanvasItem

###Debug menu controller
#shows and hides a part of the node tree, while pausing the rest
#this behavior is tied to the "debug_toggle" option, which I've set to 
#backtick (`)

@export var pause_on_show := true

func _input(input_event:InputEvent):
	if input_event.is_action("debug_toggle") && input_event.is_pressed():
		visible = !visible
		if pause_on_show: 
			process_mode = PROCESS_MODE_ALWAYS if visible else PROCESS_MODE_INHERIT
			get_tree().paused = visible
		
