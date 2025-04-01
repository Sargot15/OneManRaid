extends "res://game/enemies/bosses/abilities/boss_ability.gd"

signal finished_cast

@onready var time_between_healings_timer = $TimeBetweenHealings
@onready var time_start_healing_boss_timer = $TimeToStartHealingBoss

@export var shield_life : float
@export var spawners : Array[Node2D]
@export var shield : PackedScene
@export var amount_heal : float

var shield_ins

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cast():
	is_casteable = false
		
	for spawner in spawners:
		spawner.enable()
	
	time_casting_timer.wait_time = time_casting
	time_casting_timer.start()
	
	time_start_healing_boss_timer.start()
	
	shield_ins = shield.instantiate()
	shield_ins.shield_life = shield_life
	add_child(shield_ins)
	
	shield_ins.connect("shield_destroyed", on_shield_destroyed)

func on_shield_destroyed():
	finish_cast()

func finish_cast():
	for spawner in spawners:
		spawner.disable()
		
	shield_ins.queue_free()
	
	time_between_healings_timer.stop()
	time_start_healing_boss_timer.stop()
	
	time_between_casts_timer.wait_time = time_between_casts
	time_between_casts_timer.start()
	
	finished_cast.emit()
	
func _on_time_between_casts_timer_timeout():
	is_casteable = true 


func _on_time_to_heal_boss_timeout():
	time_between_healings_timer.start()
	
func _on_time_between_healings_timeout():
	#TODO: Esto se está lanzando incluso cuando se acaba el hechizo, habría que parar todos los timers en el finish_cast?
	if (boss.has_method("heal")):
		boss.heal(amount_heal)
