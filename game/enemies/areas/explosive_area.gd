class_name ExplosiveArea extends Area2D

@onready var timer_to_explode = $TimeToExplode
@onready var polygon_shape = $Polygon2D
@onready var collision = $CollisionPolygon2D

var shader = load("res://game/shaders/areas/explosive_area_filler_material.gdshader").duplicate()
var area_created : bool = false

var damage : float

### SHAPE PROPERTIES
var area_shape : ExplosiveAreaConfig.AreaShape
var points_to_draw_circle : int = 64

# Circle shape
var circle_radius : float

## Circle incomplete shape
var circle_incomplete_radius : float
var circle_incomplete_percentage_open : float

## Circle inverted
var circle_inverted_radius : float

var custom_points : PackedVector2Array

### END SHAPE PROPERTIES

func config_area_explosive(config : ExplosiveAreaConfig) -> void:
	damage = config.damage
	area_shape = config.area_shape
	circle_radius = config.circle_radius
	circle_incomplete_radius = config.circle_incomplete_radius
	circle_incomplete_percentage_open = config.circle_incomplete_percentage_open
	circle_inverted_radius = config.circle_inverted_radius
	custom_points = config.custom_points
	
	timer_to_explode.wait_time = config.explosion_time
	timer_to_explode.start()
	
	# Create material and shader for the explosion
	var shader_material = ShaderMaterial.new()
	shader_material.shader = shader
	polygon_shape.material = shader_material
		
	_create_area()
	
	area_created = true
	
func _process(delta):
	if area_created:
		polygon_shape.material.set_shader_parameter("progress", 1 - (timer_to_explode.time_left / timer_to_explode.wait_time))
	
func _create_area() -> void:
	# Get the points of the shape of the area
	var points : PackedVector2Array = _create_polygon_points()
	
	# Visual shape
	polygon_shape.polygon = points
	
	# Collision
	collision.polygon = points
	
	
func _create_polygon_points() -> PackedVector2Array:
	match area_shape:
		ExplosiveAreaConfig.AreaShape.CIRCLE:
			return _create_circle_points()
		ExplosiveAreaConfig.AreaShape.CIRCLE_INCOMPLETE:
			return _create_circle_incomplete_points()
		ExplosiveAreaConfig.AreaShape.CIRCLE_INVERTED:
			return _create_circle_inverse_points()
		ExplosiveAreaConfig.AreaShape.CUSTOM:
			return custom_points
			
	return PackedVector2Array()
	
	
func _create_circle_points() -> PackedVector2Array:
	var points = PackedVector2Array()
	
	for i in range(points_to_draw_circle):
		var angle = i * (2 * PI / points_to_draw_circle)
		points.append(Vector2(cos(angle), sin(angle)) * circle_radius)
		
	return points
	
func _create_circle_incomplete_points() -> PackedVector2Array:
	var points = PackedVector2Array()
	
	points.append(Vector2.ZERO)
	
	for i in range(points_to_draw_circle * (1 - circle_incomplete_percentage_open) + 1):
		var angle = i * (2 * PI / points_to_draw_circle)
		points.append(Vector2(cos(angle), sin(angle)) * circle_incomplete_radius)
		
	return points
	
func _create_circle_inverse_points() -> PackedVector2Array:
	var points = PackedVector2Array()
	
	points.append(Vector2(7500, -7500))
	points.append(Vector2(-7500, -7500))
	points.append(Vector2(-7500, 7500))
	points.append(Vector2(7500, 7500))
	points.append(Vector2(7500, -7500))

	# Add the safe circle
	var angle : float = 0
	
	for i in range(points_to_draw_circle + 1):
		angle = i * (2 * PI / points_to_draw_circle)
		points.append(Vector2(cos(angle), sin(angle)) * circle_inverted_radius)
		
	return points
	
func _on_time_to_explode_timeout():
	_apply_damage()
	queue_free()

func _apply_damage() -> void:
	for body in get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(damage, Globals.COLOR_TYPE.GRAY)
