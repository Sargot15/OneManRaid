class_name DamageArea extends Area2D

signal area_destroyed(area : DamageArea)

@onready var timer_alive : Timer = $TimerAlive

var color_area : Color = Color(1, 0, 0, 0.5)

var damage : float

# List of player inside the area
var players_inside = {}

### SHAPE PROPERTIES
var area_shape : DamageAreaConfig.AreaShape
var points_to_draw_circle : int = 64

# Circle shape
var circle_radius : float

# Circle incomplete shape
var circle_incomplete_radius : float
var circle_incomplete_percentage_open : float

# Circle inverted
var circle_inverted_radius : float

### END SHAPE PROPERTIES

func config_area_damage(config : DamageAreaConfig) -> void:
	damage = config.damage
	area_shape = config.area_shape
	circle_radius = config.circle_radius
	circle_incomplete_radius = config.circle_incomplete_radius
	circle_incomplete_percentage_open = config.circle_incomplete_percentage_open
	circle_inverted_radius = config.circle_inverted_radius
	
	if not config.permanent_alive:
		var time_alive : float = randf_range(config.min_time_alive, config.max_time_alive)
		# Add timer to set the time the area is going to be active
		timer_alive.wait_time = time_alive
		timer_alive.start()
	
	_create_shape()
	
	
func _create_shape() -> void:
	match area_shape:
		DamageAreaConfig.AreaShape.CIRCLE:
			_create_circle_shape()
		DamageAreaConfig.AreaShape.CIRCLE_INCOMPLETE:
			_create_incomplete_circle_shape()
		DamageAreaConfig.AreaShape.CIRCLE_INVERTED:
			_create_inverse_circle_shape()
			

func destroy() -> void:
	area_destroyed.emit(self)
	queue_free()


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


func _on_timer_alive_timeout():
	destroy()
	

func _create_circle_shape() -> void:
	# Visuals
	var polygon = Polygon2D.new()
	polygon.color = color_area
	var points = PackedVector2Array()
	for i in range(points_to_draw_circle):
		var angle = i * (2 * PI / points_to_draw_circle)
		points.append(Vector2(cos(angle), sin(angle)) * circle_radius)
	polygon.polygon = points
	add_child(polygon)
	
	# Collision
	var collision_shape : CollisionShape2D = CollisionShape2D.new()
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = circle_radius
	add_child(collision_shape)
	
func _create_incomplete_circle_shape() -> void:
	# Visuals
	var polygon = Polygon2D.new()
	polygon.color = color_area
	var points = PackedVector2Array()
	points.append(Vector2.ZERO)
	for i in range(points_to_draw_circle * (1 - circle_incomplete_percentage_open) + 1):
		var angle = i * (2 * PI / points_to_draw_circle)
		points.append(Vector2(cos(angle), sin(angle)) * circle_incomplete_radius)
	polygon.polygon = points
	add_child(polygon)
	
	# Collision
	var collision_shape = CollisionPolygon2D.new()
	collision_shape.polygon = points
	add_child(collision_shape)
	
func _create_inverse_circle_shape() -> void:
	# Visuals
	var polygon = Polygon2D.new()
	polygon.color = color_area
	
	var points = PackedVector2Array()
	
	# Add points outside the circle
	# TODO: At this momento we use this values to cover all the screen, but we should be able to read the limits of the screen
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

	polygon.polygon = points
	add_child(polygon)
	
	# Collision
	var collision_shape = CollisionPolygon2D.new()
	collision_shape.polygon = points
	add_child(collision_shape)
