extends Node

@export var spawners : Array[Node2D]

var is_activated : bool = false

func activate():
	for spawner in spawners:
		spawner.enable()
	is_activated = true
	
func deactivate():
	for spawner in spawners:
		spawner.disable()
	is_activated = false
