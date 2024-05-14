extends Node2D

@onready var kill_timer = $KillTimer

@export var speed : float = 400
@export var damage : float
@export var is_static : bool = false
@export var type : Globals.COLOR_TYPE

func _ready():
	Globals.debug_total_enemy_bullets += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!is_static):
		position += transform.x * speed * delta
	

func _on_kill_timer_timeout():
	Globals.debug_total_enemy_bullets -= 1
	queue_free()


func _on_body_entered(body):
	if(body.has_method("take_damage")):
		body.take_damage(damage, type)
	
	Globals.debug_total_enemy_bullets -= 1
	queue_free()

func set_time_alive(time_alive : float):
	kill_timer.stop()
	if (time_alive > 0):
		kill_timer.wait_time = time_alive
		kill_timer.start()
