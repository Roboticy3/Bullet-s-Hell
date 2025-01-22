extends Node

var SHADOW_DIAMETER := 50.0

@export var shadow:PackedScene
@export var hole:PackedScene

func _ready() -> void:
	
	if !(Accessor.player is Bullet):
		set_physics_process(false)
		Accessor.player_set.connect(func ():
			set_physics_process(Accessor.player is Bullet)
			attach_hole_pusher(Accessor.player)
		)
	else:
		attach_hole_pusher(Accessor.player)

func attach_hole_pusher(player:Bullet):
	player.area_entered.connect(hole_pusher)

func hole_pusher(area:Area2D):
	if (area is Obstacle):
		push_shadow_to_player_transform(hole)

var last_shadow_position := Vector2.INF

func _physics_process(delta: float) -> void:
	
	var distance_traveled := Accessor.player.position.\
		distance_to(last_shadow_position)
	if distance_traveled > SHADOW_DIAMETER:
		push_shadow_to_player_transform(shadow)
		last_shadow_position = Accessor.player.position
	
func push_shadow_to_player_transform(scene:PackedScene) -> void:
	if scene == null || !scene.can_instantiate(): return
	
	var instance := scene.instantiate()
	#print("adding shadow at", Accessor.player.position)
	add_child(instance)
	instance.transform = Accessor.player.transform
