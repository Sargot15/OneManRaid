class_name TheHunt extends BossAbility

@export var spawners : Array[Node2D]

func cast() -> void:
	is_casteable = false
	is_casting = true
		
	for spawner in spawners:
		spawner.enable()
	
	time_casting_timer.wait_time = time_casting
	time_casting_timer.start()

func stop() -> void:
	for spawner in spawners:
		spawner.disable()
	
	time_casting_timer.stop()
	is_casting = false

func _on_time_casting_timer_timeout():
	for spawner in spawners:
		spawner.disable()
	
	time_between_casts_timer.wait_time = time_between_casts
	time_between_casts_timer.start()
	is_casting = false
	
func _on_time_between_casts_timer_timeout():
	is_casteable = true 
