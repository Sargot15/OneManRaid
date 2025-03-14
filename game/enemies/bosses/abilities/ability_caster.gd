extends Node

var abilities : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	abilities = $Abilities
	$TryCastAbilityTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_try_cast_ability_timer_timeout():
	var total_weight : float = 0
	
	for ability in abilities.get_children():
		if (ability.is_casteable):
			total_weight += ability.weight
	
	var pick = randf_range(0, total_weight)
	var accumulated_weight : float = 0
	
	for ability in abilities.get_children():
		if (ability.is_casteable):
			accumulated_weight += ability.weight
			if pick < accumulated_weight:
				ability.cast()
				break
	
