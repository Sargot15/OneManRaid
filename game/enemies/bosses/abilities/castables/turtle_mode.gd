class_name TurtleMode extends BossAbility

signal finished_cast

@export var shield_life : float
@export var spawners : Array[Node2D]
@export var shield : PackedScene
@export var amount_heal : float

@onready var time_between_healings_timer = $TimeBetweenHealings
@onready var time_start_healing_boss_timer = $TimeToStartHealingBoss

var shield_ins

func cast() -> void:
	is_casteable = false
	is_casting = true
		
	for spawner in spawners:
		spawner.enable()
	
	time_casting_timer.wait_time = time_casting
	time_casting_timer.start()
	
	time_start_healing_boss_timer.start()
	
	shield_ins = shield.instantiate()
	shield_ins.shield_life = shield_life
	add_child(shield_ins)
	
	shield_ins.connect("shield_destroyed", on_shield_destroyed)

func stop() -> void:
	finish_cast()

func on_shield_destroyed() -> void:
	finish_cast()

func finish_cast() -> void:
	for spawner in spawners:
		spawner.disable()
		
	shield_ins.queue_free()
	
	time_between_healings_timer.stop()
	time_start_healing_boss_timer.stop()
	
	time_between_casts_timer.wait_time = time_between_casts
	time_between_casts_timer.start()
	
	finished_cast.emit()
	
	is_casting = false
	
func _on_time_between_casts_timer_timeout():
	is_casteable = true 


func _on_time_to_heal_boss_timeout():
	time_between_healings_timer.start()
	
func _on_time_between_healings_timeout():
	if boss.has_method("heal"):
		boss.heal(amount_heal)
