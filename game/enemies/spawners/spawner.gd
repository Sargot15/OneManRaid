extends Node2D

@onready var shoot_timer = $ShootTimer
@onready var rotater = $Rotater

const bullet_scene = preload("res://game/enemies/bullets/bulletEnemy.tscn")

@export var rotate_speed = 100
@export var shooter_time_wait_time = 0.2
@export var spawn_point_count = 4
@export var radius = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	var step = 2 * PI / spawn_point_count
	
	for i in range (spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
		
	shoot_timer.wait_time = shooter_time_wait_time
	shoot_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)

func _on_shoot_timer_timeout():
	for s in rotater.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
