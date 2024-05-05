extends Node

@onready var spawner_points = $"../../SpawnerPoints"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize_pattern(radius: float, spawn_point_count: int):
	var step = 2 * PI / spawn_point_count
	
	for i in range (spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		spawner_points.add_child(spawn_point)
