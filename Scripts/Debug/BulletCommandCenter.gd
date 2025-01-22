extends RichTextLabel

### Debug console
#a nice way to add custom commands for testing, see set_speed and 
#set_position for examples

#define commands here by mapping commmand names to functions
#commands should take a PackedStringArray as an argument, which
#will contain whatever the user sent over
var command_map := {
	"set_speed":set_speed,
	"set_position":com_set_position,
	"set_control_type":set_control_type,
	"bind":bind,
	
	#if you use a command mapped to something that isn't a function,
	#you should get the message "command is registered incorrectly"
	"invalid":0 
}

var player:Bullet

#send a command to this command center
func give_command(command:String):
	
	#first, clean the command up a little, getting rid of whatever it 
	#might have picked up on the way over
	var re := RegEx.new()
	re.compile("[^A-Za-z0-9 _]")
	command = re.sub(command, "", true)
	
	#then, make sure it has a valid number of arguments
	var args:PackedStringArray = command.split(" ")
	give_command_parsed(args)

func give_command_parsed(args:PackedStringArray):
	
	if args.size() == 0: 
		append_text("error: empty command")
		return
	
	append_text("running command: " + args[0] + "\n")
	
	#then, make sure the command name (args[0]) is mapped to
	#a valid command, which takes a step to check if the command
	#is mapped to *anything*, then to check that it's mapped to
	#a valid *function*
	if !command_map.has(args[0]): 
		append_text(args[0] + " is not a registered command\n")
		return 
	var command_object = command_map[args[0]]
	
	if !(command_object is Callable): 
		append_text(args[0] + " is registered incorrectly\n")
		return
	
	#since most commands reference the player, 
	#check that this reference is valid
	if !(Accessor.player is Bullet):
		append_text("Player " + str(Accessor.player) + " is not a valid Bullet\n")
		return
	player = Accessor.player
	
	#finally, execute the command with the given arguments
	#this can still throw an error if the function doesn't
	#take a PackedStringArray as args, so uh yeah don't do that.
	command_object.call(args)

#a command to set the speed of the player
func set_speed(args:PackedStringArray):
	if (args.size() < 2):
		append_text("set_speed requires an argument: 'set_speed [speed]'\n")
	var amount = float(args[1])

	player.state.speed = amount

#a command to set the position of a node
#set_position is already taken as a function name
func com_set_position(args:PackedStringArray):
	if (args.size() < 3):
		append_text(
			"set_position requires 2 arguments with an optional third: " + \
		 	"'set_position [x] [y] [absolute node path]'\n"
		)
		return
	
	var target = player
	if (args.size() > 3 && args[3].length() > 0):
		var path := NodePath(args[3])
		if !path.is_absolute():
			append_text("path " + args[3] + " should be absolute: 'root/...'")
			return
		target = get_node_or_null(args[3])
		if !(target is Node2D):
			append_text(
				"target " + str(target) + " at " + args[3] + \
				" is not a Node2D"
			)
			return
	
	
	var new_pos := Vector2(float(args[1]), float(args[2]))
	target.position = new_pos

func keys_to_args_string(keys:Array) -> String:
	if keys.size() == 0: return "[]"
	var s := "["
	for k in keys.size() - 1:
		s += str(keys[k]) + "|"
	s += keys[keys.size() - 1] + "]"
	return s

func set_control_type(args:PackedStringArray):
	
	var controller = Accessor.player_controller
	if !(controller is BulletController):
		append_text("Can't edit " + str(controller) + " as a controller!")
		return
	
	var type_names = controller.CONTROL_MODE.keys()
	
	if (args.size() < 2):
		append_text("set_control_type requires 1 argument: set_contol_type " + \
			keys_to_args_string(type_names) + "\n"
		)
		return
	
	var type_name_idx = type_names.find(args[1].to_upper())
	if (type_name_idx == -1):
		append_text("Invalid type name. " + \
			"set_control_type requires 1 argument: set_contol_type " +\
			keys_to_args_string(type_names) + "\n"
		)
		return
	
	controller.update_control_mode(type_name_idx)
	
	append_text("set control type to " + args[1] + "\n")

var binds := {}
func bind(args:PackedStringArray):
	if args.size() < 3:
		append_text("bind requires at least 2 arguments:" +
			"'bind [key] [command]'")
	
	var com := args.slice(2)
	var key := args[1].to_lower()
	
	binds[key] = com

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_pressed():
		var key_name:String = event.as_text_key_label()
		key_name = key_name.to_lower()
		if binds.has(key_name):
			give_command_parsed(binds[key_name])
