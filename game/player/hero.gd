extends Node2D

signal health_updated(hero_type : Globals.COLOR_TYPE ,health : int,max_health : int)

@export var hero_type : Globals.COLOR_TYPE

# Called when the node enters the scene tree for the first time.
func _ready():
	health_updated.emit(hero_type, $HeroStats.health, $HeroStats.max_health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
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
