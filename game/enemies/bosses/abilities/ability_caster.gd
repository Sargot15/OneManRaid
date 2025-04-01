extends Node

@export var boss : Node

var abilities : Node2D
var can_cast : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	abilities = $Abilities
	$TryCastAbilityTimer.start()
	
	for ability in abilities.get_children():
		ability.boss = boss


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_try_cast_ability_timer_timeout():
	if (can_cast):
		return

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
				if (ability.is_unique_cast):
					can_cast = false
					ability.connect("finished_cast", on_ability_finished_cast)
				break
	
func on_ability_finished_cast():
	can_cast = true
