extends Node

###Display the state of the player
#BulletState is designed for this sort of display
#this script converts the player's state to a string and shows it
#in a RichTextLabel

@export_node_path var player_path := NodePath("../../CharacterBody2D")
@onready var player = get_node_or_null(player_path)

@export_node_path var label_path := NodePath("RichTextLabel")
@onready var label := get_node_or_null(label_path)

func _process(delta) -> void:
	if (label is RichTextLabel && player is Bullet):
		label.bbcode_enabled = true
		label.text = player.state._to_string()
