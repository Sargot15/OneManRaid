extends Node2D

@onready var shoot_timer = $ShootTimer
@onready var change_bullet_timer = $ChangeBulletTimer
@onready var rotater = $Rotater

var bullet_scene : PackedScene
#var example =  preload("res://game/enemies/bullets/bulletEnemy.tscn")

@export var rotate_speed = 100
@export var spawn_point_count = 4
@export var radius = 25
@export var bullet_types : Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_scene = bullet_types.pick_random()
	
	var step = 2 * PI / spawn_point_count
	
	for i in range (spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)

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


func _on_change_bullet_timer_timeout():
	bullet_scene = bullet_types.pick_random()
