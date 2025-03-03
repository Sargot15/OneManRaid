extends Node

@export var spawners : Array[Node2D]

func activate():
	for spawner in spawners:
		spawner.enable()
	
func deactivate():
	for spawner in spawners:
		spawner.disable()
	
