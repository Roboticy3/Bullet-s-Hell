extends Node
class_name Teleport

### Teleport
#attached to the player as a child by PowerUpTrigger.gd. Once created, it adds
#invincibility to the player, and frees itself from memory after its alloted time.

#This script is attached to the root of Scenes/Power Up/Teleport.tscn, which
#contains all the necessary components to teleport the player to another location
#until the root is freed, causing those nodes to be freed as well.
var player:Bullet

func _on_body_entered(body):
	var p = get_parent()
	if (p is Bullet):
		player = p
		var direction = body.velocity.normalized()
		var teleport_distance = 250
		var new_position = body.position + direction * teleport_distance
		body.position = new_position
		queue_free()  # Remove the teleport power-up after use
