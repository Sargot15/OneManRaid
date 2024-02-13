extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func take_damage(damage):
	# Health should not be lower than 0
	$HeroStats.health = max($HeroStats.health - damage, 0)

func is_alive() -> bool:
	return $HeroStats.health > 0
	
func get_speed() -> float:
	return $HeroStats.speed
