class_name SpawnerRotater extends Node2D

@onready var spawner_points = $"../SpawnerPoints"

var enabled : bool = false
var rotate_speed : float = 0
var rotate_clockwise : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enabled:
		var deg_to_rotate = rotate_speed * delta
		if not rotate_clockwise:
			deg_to_rotate *= -1
		var new_rotation = spawner_points.rotation_degrees + deg_to_rotate
		spawner_points.rotation_degrees = fmod(new_rotation, 360)

func initialize(rot_speed : float, rot_clockwise : bool) -> void:
	enabled = true
	rotate_speed = rot_speed
	rotate_clockwise = rot_clockwise
