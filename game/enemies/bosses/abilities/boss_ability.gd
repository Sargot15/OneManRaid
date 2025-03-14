extends Node

@onready var time_casting_timer = $TimeCastingTimer
@onready var time_between_casts_timer = $TimeBetweenCastsTimer

@export var ability_name : String
@export var weight : float # The higher, the more probability to cast this ability
@export var time_casting : float
@export var time_between_casts : float

var is_casteable : bool = true

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
