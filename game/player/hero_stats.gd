extends Node

# Base stats
@export var max_health : float
@export var defense : float
@export var speed : float
@export var attack : float
@export var attack_range : float
@export var attack_speed : float

# Actual stats
var health : float

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(health)
