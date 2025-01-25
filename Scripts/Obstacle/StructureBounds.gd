extends Area2D

### Hide the ceiling of a building when a player enters

func _ready():
	area_entered.connect(check_player_entered)
	area_exited.connect(check_player_exited)

func check_player_entered(area:Area2D):
	if area is Bullet:
		visible = false
func check_player_exited(area:Area2D):
	if area is Bullet:
		visible = true
