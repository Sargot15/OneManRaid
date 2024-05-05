extends Node2D

@onready var spawner_points = $"../SpawnerPoints"

var enabled : bool = false
var rotate_speed : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (enabled):
		var new_rotation = spawner_points.rotation_degrees + rotate_speed * delta
		spawner_points.rotation_degrees = fmod(new_rotation, 360)

func initialize(rot_speed : float):
	enabled = true
	rotate_speed = rot_speed
