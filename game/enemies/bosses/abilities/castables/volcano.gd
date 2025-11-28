class_name Volcano extends BossAbility

@export var explosion_area_scene: PackedScene
@export var explosion_area_config : ExplosiveAreaConfig
@export var areas_per_repetition : int = 15
@export var num_repetitions : int = 3
@export var time_between_repetitions : float = 1.0

var num_repetition : int = 0
var timer_repetitions : Timer

func cast() -> void:
	is_casteable = false
	is_casting = true
		
	num_repetition = 0
	
	# Create timer to control the time between repetitions
	timer_repetitions = Timer.new()
	timer_repetitions.one_shot = true
	add_child(timer_repetitions)
	timer_repetitions.timeout.connect(_on_timer_repetitions_timeout)
	
	_cast_new_repetition()

func stop() -> void:
	is_casting = false
	
	time_between_casts_timer.wait_time = time_between_casts
	time_between_casts_timer.start()
	
func _on_time_between_casts_timer_timeout():
	print("is casteable")
	is_casteable = true 
	
func _cast_new_repetition() -> void:
	if num_repetition < num_repetitions:
		num_repetition += 1
		
		# Create the explosive areas
		_create_areas()
		
		# Set the next timer
		timer_repetitions.wait_time = time_between_repetitions
		timer_repetitions.start()
		
	else:
		stop()
		

func _create_areas() -> void:
	for i in range(areas_per_repetition):
		var area = explosion_area_scene.instantiate() as ExplosiveArea
		add_child(area)
		
		# Set area position
		var initial_pos = Vector2.ZERO
		if explosion_area_config.pos_relative_to_boss:
			initial_pos = boss.global_position
		var offset_x : float = randf_range(explosion_area_config.pos_random_x_left_range, explosion_area_config.pos_random_x_right_range)
		var offset_y : float = randf_range(explosion_area_config.pos_random_y_top_range, explosion_area_config.pos_random_y_bottom_range)
		area.global_position = initial_pos + Vector2(offset_x, offset_y)
			
		area.config_area_explosive(explosion_area_config)
		
func _on_timer_repetitions_timeout() -> void:
	_cast_new_repetition()
