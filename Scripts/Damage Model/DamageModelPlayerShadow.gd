extends Node

var SHADOW_TIME_FACTOR := 200.0
var MAX_SHADOW_TIME := 2.0
@onready var timer := Timer.new()

@export var shadow:PackedScene

func _ready() -> void:
	
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(push_shadow)
	
	if !(Accessor.player is Bullet):
		set_physics_process(false)
		Accessor.player_set.connect(func ():
			set_physics_process(Accessor.player is Bullet)
		)

func _physics_process(delta: float) -> void:
	var speed := Accessor.player.state.speed
	if (is_zero_approx(sqrt(speed))): return
	
	var timer_target := SHADOW_TIME_FACTOR / speed
	if timer_target != clampf(timer_target, 0.0, MAX_SHADOW_TIME): return
	
	if timer.is_stopped():
		#print("drop a shadow in ", roundf(timer_target * 100.0), " time")
		timer.start(timer_target)
	
func push_shadow() -> void:
	if !shadow.can_instantiate(): return
	
	var instance := shadow.instantiate()
	print("adding shadow at", Accessor.player.position)
	add_child(instance)
	instance.position = Accessor.player.position
