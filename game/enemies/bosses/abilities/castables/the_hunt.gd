extends "res://game/enemies/bosses/abilities/boss_ability.gd"

@export var spawners : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cast():
	print("Casteando 'The Hunt'")
	for spawner in spawners:
		spawner.enable()
		
	is_casteable = false
	
	time_casting_timer.wait_time = time_casting
	time_casting_timer.start()

func _on_time_casting_timer_timeout():
	print("Deshabilitando spawners de 'The Hunt'")
	for spawner in spawners:
		spawner.disable()
	
	time_between_casts_timer.wait_time = time_between_casts
	time_between_casts_timer.start()
	
func _on_time_between_casts_timer_timeout():
	is_casteable = true 
