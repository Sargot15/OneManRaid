extends Node

@export var max_health : float
@export var speed : float

var health : float

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(health)
