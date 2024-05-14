extends Node

@onready var spawner_points = $"../../SpawnerPoints"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize_pattern(direction: float, separation: float, spawn_point_count: int):
	var start_point : float = (separation * spawn_point_count) / 2;
	
	if (spawn_point_count % 2 == 0):
		start_point -= separation / 2

	# First we set the points in the Y axis
	for i in range (spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(1, start_point - i * separation)
		spawn_point.position = pos
		spawner_points.add_child(spawn_point)
		
	# Then we rotated to point to the direction
	spawner_points.rotation_degrees = fmod(direction, 360)
		
