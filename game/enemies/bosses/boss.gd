extends Node2D

# Base stats
@export var max_health : float

# Actual stats
var health : float
var actual_phase : int

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func take_damage(damage : float):
	health -= damage
