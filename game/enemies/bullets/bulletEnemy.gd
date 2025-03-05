extends Node2D

class_name bulletEnemy

@onready var kill_timer = $KillTimer
@onready var hit_again_timer = $HitAgainTimer
@onready var start_hitting_timer = $StartHittingTimer

@onready var collisioner = $CollisionShape2D

@export var speed : float = 400
@export var damage : float
@export var is_static : bool = false
## When reached this distance the bullet will be destroyed unless it's -1
@export var max_distance : float = -1 
@export var destroy_on_collistion : bool = true
@export var type : Globals.COLOR_TYPE

var hit_recently : bool = false
var can_hit : bool = true
var distance_traveled : float = 0

func _ready():
	Globals.debug_total_enemy_bullets += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!is_static):
		position += transform.x * speed * delta
		distance_traveled += scale.x * speed * delta
		
	if (max_distance != -1 && distance_traveled >= max_distance):
		destroy()
	

func _on_kill_timer_timeout():
	destroy()


func _on_body_entered(body):
	if (!can_hit):
		return
		
	if (body.has_method("take_damage") && !hit_recently):
		body.take_damage(damage, type)
		hit_recently = true
		hit_again_timer.start()
	
	if (destroy_on_collistion):
		destroy()

func _on_hit_again_timer_timeout():
	hit_recently = false


func set_time_alive(time_alive : float):
	kill_timer.stop()
	if (time_alive > 0):
		kill_timer.wait_time = time_alive
		kill_timer.start()

func destroy():
	Globals.debug_total_enemy_bullets -= 1
	queue_free()

func set_time_start_hitting(time_to_hit : float):
	if (time_to_hit > 0):
		start_hitting_timer.wait_time = time_to_hit
		start_hitting_timer.start()
		can_hit = false
		

func _on_start_hitting_timer_timeout():
	can_hit = true
