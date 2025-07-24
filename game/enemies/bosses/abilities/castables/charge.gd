class_name Charge extends BossAbility

@export var spawners : Array[Node2D]
@export var boss_mov_distance : float
@export var boss_mov_direction : Vector2
@export var boss_mov_speed : float

var target_boss_position : Vector2


func cast() -> void:
	is_casteable = false
	is_casting = true
		
	for spawner in spawners:
		spawner.enable()
	
	# Set movement boss variables
	var direction : Vector2 = (boss.global_position - boss_mov_direction).normalized()
	target_boss_position.x = boss.global_position.x - (direction.x * boss_mov_distance)
	target_boss_position.y = boss.global_position.y - (direction.y * boss_mov_distance)
	
	boss_movement_controller.override_with(func(delta): _movement_boss(delta))


func stop() -> void:
	for spawner in spawners:
		spawner.disable()
	
	boss_movement_controller.clear_override()
	
	time_between_casts_timer.wait_time = time_between_casts
	time_between_casts_timer.start()
	is_casting = false
	
	
func _physics_process(delta):
	if is_casting and boss.global_position.distance_to(target_boss_position) < 1:
		stop()


func _movement_boss(delta):
	boss.global_position = boss.global_position.move_toward(target_boss_position, boss_mov_speed * delta)


func _on_time_between_casts_timer_timeout():
	is_casteable = true 
