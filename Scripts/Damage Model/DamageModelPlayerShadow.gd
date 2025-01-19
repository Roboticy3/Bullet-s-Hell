extends Node

var SHADOW_DIAMETER := 100.0

@export var shadow:PackedScene

func _ready() -> void:
	
	if !(Accessor.player is Bullet):
		set_physics_process(false)
		Accessor.player_set.connect(func ():
			set_physics_process(Accessor.player is Bullet)
		)

var last_shadow_position := Vector2.INF

func _physics_process(delta: float) -> void:
	
	var distance_traveled := Accessor.player.position.\
		distance_to(last_shadow_position)
	if distance_traveled > SHADOW_DIAMETER:
		push_shadow()
		last_shadow_position = Accessor.player.position
	
func push_shadow() -> void:
	if !shadow.can_instantiate(): return
	
	var instance := shadow.instantiate()
	#print("adding shadow at", Accessor.player.position)
	add_child(instance)
	instance.position = Accessor.player.position
