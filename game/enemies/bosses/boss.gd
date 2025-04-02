extends Node2D

# Base stats
@export var max_health : float

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

func take_damage(damage : float):
	update_health(-damage)

func heal(heal_amount : float):
	update_health(heal_amount)
	
func update_health(amount : float):
	# Check if something is updating the health
	if updating_health:
		await get_tree().process_frame  # Espera hasta que termine la otra ejecución

	updating_health = true
	
	health += amount
	
	if (health > max_health):
		health = max_health
		
	updating_health = false
