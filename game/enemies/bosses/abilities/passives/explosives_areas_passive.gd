class_name ExplosiveAreasPassive extends Node

@export var boss : Boss

@export var spawn_time : float # Time in seconds between spawning every areas

@export var explosive_area_scene: PackedScene
@export var explosive_area_config : ExplosiveAreaConfig

var is_activated : bool = false
var timer_spawning : Timer

func activate() -> void:
	# Create timer to control the time between repetitions
	timer_spawning = Timer.new()
	add_child(timer_spawning)
	timer_spawning.wait_time = spawn_time
	timer_spawning.start()
	timer_spawning.timeout.connect(_on_timer_spawning_timeout)
	
	
	is_activated = true
	
func deactivate() -> void:
	# Destroy the timer
	timer_spawning.queue_free()
	
	is_activated = false
	
func _on_timer_spawning_timeout() -> void:
	var area = explosive_area_scene.instantiate() as ExplosiveArea
	add_child(area)
	
	# Set area position
	var initial_pos = Vector2.ZERO
	if explosive_area_config.pos_relative_to_boss:
		initial_pos = boss.global_position
	var offset_x : float = randf_range(explosive_area_config.pos_random_x_left_range, explosive_area_config.pos_random_x_right_range)
	var offset_y : float = randf_range(explosive_area_config.pos_random_y_top_range, explosive_area_config.pos_random_y_bottom_range)
	area.global_position = initial_pos + Vector2(offset_x, offset_y)
		
	area.config_area_explosive(explosive_area_config)
