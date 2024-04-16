extends Node2D

signal health_updated(hero_type : Globals.COLOR_TYPE ,health : int,max_health : int)

@onready var weapon : Node2D = $Weapon

@export var hero_type : Globals.COLOR_TYPE

var time_to_next_attack : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	health_updated.emit(hero_type, $HeroStats.health, $HeroStats.max_health)
	time_to_next_attack = 0

func _process(delta):
	if (time_to_next_attack > 0):
		time_to_next_attack -= delta

func shoot():
	if (time_to_next_attack <= 0):
		weapon.shoot()
		time_to_next_attack = 1 / $HeroStats.attack_speed
	
func take_damage(damage : float, color_type : Globals.COLOR_TYPE):
	# Bullet does not do damage if color type are the same
	if (hero_type == color_type):
		#TODO: To be designed what happen in this scenario
		pass
		
	else: 
		# Health should not be lower than 0
		$HeroStats.health = max($HeroStats.health - damage, 0)
		health_updated.emit(hero_type, $HeroStats.health, $HeroStats.max_health)
		

func is_alive() -> bool:
	return $HeroStats.health > 0
	
func get_speed() -> float:
	return $HeroStats.speed
