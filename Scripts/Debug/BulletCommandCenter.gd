extends RichTextLabel

### Debug console
#a nice way to add custom commands for testing, see set_speed and 
#set_position for examples

#reference to the player so their state can be manipulated
#it's good practice to ask `if(player is Bullet)` before working with it
@export_node_path var player_path := \
	NodePath("../../../../Area2D")
@onready var player = get_node_or_null(player_path)

#define commands here by mapping commmand names to functions
#commands should take a PackedStringArray as an argument, which
#will contain whatever the user sent over
var command_map := {
	"set_speed":set_speed,
	"set_position":com_set_position,
	
	#if you use a command mapped to something that isn't a function,
	#you should get the message "command is registered incorrectly"
	"invalid":0 
}

#send a command to this command center
func give_command(command:String):
	
	#first, clean the command up a little, getting rid of whatever it 
	#might have picked up on the way over
	var re := RegEx.new()
	re.compile("[^A-Za-z0-9 _]")
	command = re.sub(command, "", true)
	
	#then, make sure it has a valid number of arguments
	var args:PackedStringArray = command.split(" ")
	if args.size() == 0: 
		append_text("error: empty command")
		return
	
	append_text("running command: " + command + "\n")
	
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
	if !(player is Bullet):
		append_text("Player " + str(player) + " is not a valid Bullet\n")
		return
	
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
	
	
