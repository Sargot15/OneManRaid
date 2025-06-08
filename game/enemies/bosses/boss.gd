class_name Boss extends Node2D

# Base stats
@export var max_health : float

@onready var phase_manager = $PhaseManager

# Actual stats
var health : float
var actual_phase : int

var updating_health : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func take_damage(damage : float) -> void:
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
		
	updating_health = false
