extends Node

@onready var spawner_points = $"../../SpawnerPoints"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize_pattern(direction: float, arc: float, radius: float, spawn_point_count: int):
	var start_point : float
	var step = 0
	
	if (spawn_point_count == 1):
		start_point = direction
	elif (spawn_point_count > 1):
		start_point = (direction - arc / 2)
		step = arc / (spawn_point_count - 1)
		
	for i in range (spawn_point_count):
		var spawn_point = Node2D.new()
		var angle = deg_to_rad(start_point + step * i)
		var pos = Vector2(radius, 0).rotated(angle)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		spawner_points.add_child(spawn_point)
