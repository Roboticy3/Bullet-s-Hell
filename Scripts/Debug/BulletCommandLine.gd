extends TextEdit

### Debug command line
#for sending commands to a BulletCommandCenter or elsewhere
#emits its text content on "ui_text_newline" (typically enter)
#and then clears its text

#connect BulletCommandCenters or others to this signal to recieve
#commands
signal send(command:String)

#set to true to auto-focus this textbox whenever it becomes visible
@export var hold_focus := true

func _ready() -> void:
	visibility_changed.connect(try_grab_focus, CONNECT_DEFERRED)
	try_grab_focus()

func _input(event:InputEvent):
	if event.is_action("ui_text_newline") && event.is_pressed():
		send.emit(text)
		text = ""

func try_grab_focus():
	if (visible && hold_focus): 
		grab_focus()
		text = ""
	else: release_focus()
