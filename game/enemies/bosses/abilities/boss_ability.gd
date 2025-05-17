extends Node

@onready var time_casting_timer = $TimeCastingTimer
@onready var time_between_casts_timer = $TimeBetweenCastsTimer

@export var ability_name : String
@export var weight : float # The higher, the more probability to cast this ability
@export var time_casting : float
@export var time_between_casts : float
@export var is_unique_cast : bool # If this ability is on then others abilities can not be casted

@export var stop_on_phase_change : bool
@export var stop_only_if_not_on_next_phase : bool

var boss : Node = null

var is_casteable : bool = true
var is_casting : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func cast():
	pass

func _on_time_casting_timer_timeout():
	pass 
	
func _on_time_between_casts_timer_timeout():
	pass 
	
func boss_phase_changed(ability_on_next_phase : bool):
	if is_casting and stop_on_phase_change:
		# TODO: Testear bien esto
		if not ability_on_next_phase or not stop_only_if_not_on_next_phase:
			stop()

func stop():
	pass

