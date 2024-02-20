extends Node2D

@export var hero_type : Globals.COLOR_TYPE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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

func is_alive() -> bool:
	return $HeroStats.health > 0
	
func get_speed() -> float:
	return $HeroStats.speed
