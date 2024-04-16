extends Node2D

@export var bullet_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())


func shoot():
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.position = global_position
	bullet.rotation = global_rotation
	
