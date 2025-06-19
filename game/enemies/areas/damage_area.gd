class_name DamageArea extends Area2D

@export var damage : float = 25

@export_category("Shape")
enum AreaShape {CIRCLE}
@export var area_shape : AreaShape

@export_category("Circle shape")
@export var circle_radius : float

@onready var collision_shape : CollisionShape2D = $CollisionShape2D

var color_area : Color = Color(1, 0, 0, 0.5)

# List of player inside the area
var players_inside = {}

func _ready():
	match area_shape:
		AreaShape.CIRCLE:
			_create_circle_shape()


func _on_body_entered(body : Node):
	if body.is_in_group("player"):
		players_inside[body.get_instance_id()] = body


func _on_body_exited(body : Node):
	if body.is_in_group("player"):
		players_inside.erase(body.get_instance_id())


func _on_time_to_do_damage_timeout():
	for id in players_inside:
		var player = players_inside[id]
		if is_instance_valid(player) and player.has_method("take_damage"): 
			player.take_damage(damage, Globals.COLOR_TYPE.GRAY)
			

func _create_circle_shape():
	# Visuals
	var polygon = Polygon2D.new()
	polygon.color = color_area
	var points = PackedVector2Array()
	for i in range(32):
		var angle = i * (2 * PI / 32)
		points.append(Vector2(cos(angle), sin(angle)) * circle_radius)
	polygon.polygon = points
	add_child(polygon)
	
	# Collision
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = circle_radius
	add_child(collision_shape)
