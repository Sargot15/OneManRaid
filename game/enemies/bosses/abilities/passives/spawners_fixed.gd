class_name SpawnersFixed extends Node

@export var spawners : Array[Node2D]

var is_activated : bool = false

func activate() -> void:
	for spawner in spawners:
		spawner.enable()
	is_activated = true
	
func deactivate() -> void:
	for spawner in spawners:
		spawner.disable()
	is_activated = false
