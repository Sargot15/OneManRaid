extends "res://game/enemies/bosses/abilities/boss_ability.gd"

@export var spawners : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cast():
	print("Casteando 'The Hunt'")
	for spawner in spawners:
		spawner.enable()
