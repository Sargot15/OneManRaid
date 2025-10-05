class_name Boss extends Node2D

# Base stats
@export var max_health : float

@onready var phase_manager = $PhaseManager
@onready var health_bar : ProgressBar = $CanvasLayer/FightBossInfoContainer/HealthBar
@onready var fight_time_label : Label = $CanvasLayer/FightBossInfoContainer/FightTimeLabel

# Actual stats
var health : float
var actual_phase : int

var updating_health : bool = false
var fight_started : bool = false
var fight_time : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	_update_health_bar()
	
	fight_time = 0.0
	_update_fight_timer_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fight_started:
		fight_time += delta
		_update_fight_timer_label()

func take_damage(damage : float) -> void:
	# If the boss is hit and the fight was not started, then it starts
	if not fight_started:
		_start_fight()
		
	_update_health(-damage)
	FloatingTextManager.show_damage_text(damage, global_position)

func heal(heal_amount : float) -> void:
	_update_health(heal_amount)
	FloatingTextManager.show_heal_text(heal_amount, global_position)
	
func _update_health(amount : float) -> void:
	# Check if something is updating the health
	if updating_health:
		await get_tree().process_frame  # Wait until last execution finished

	updating_health = true
	
	health += amount
	
	if health > max_health:
		health = max_health
		
	_update_health_bar()
		
	updating_health = false
	
func _start_fight() -> void:
	phase_manager.start_fight()
	fight_started = true
	
func _update_health_bar() -> void:
	health_bar.max_value = max_health
	health_bar.value = health
	

func _update_fight_timer_label():
	var minutes = int(fight_time) / 60
	var seconds = int(fight_time) % 60
	fight_time_label.text = "%02d:%02d" % [minutes, seconds]


func _on_player_detection_body_entered(body):
	if not fight_started:
		_start_fight()
