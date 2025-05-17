extends "res://game/enemies/bosses/abilities/boss_ability.gd"

@export var spawners : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cast():
	is_casteable = false
	is_casting = true
		
	for spawner in spawners:
		spawner.enable()
	
	time_casting_timer.wait_time = time_casting
	time_casting_timer.start()

func stop():
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
