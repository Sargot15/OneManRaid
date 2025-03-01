extends Node

@export var ability_name : String
@export var weight : float # The higher, the more probability to cast this ability
@export var time_casting : float
@export var time_between_casts : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func cast():
	pass
