class_name AbilityCaster extends Node

@export var boss : Node

var abilities : Array[Node]
var can_cast : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$TryCastAbilityTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_try_cast_ability_timer_timeout():
	if (!can_cast):
		return

	var total_weight : float = 0
	
	for ability in abilities:
		if (ability.is_casteable):
			total_weight += ability.weight
	
	var pick = randf_range(0, total_weight)
	var accumulated_weight : float = 0
	
	for ability in abilities:
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

func change_abilities(new_abilities : Array[Node]):
	# Notice phase change to the old abilities
	for ability in abilities:
		
		# Search if this ability is part of the new abilities
		var ability_on_next_phase : bool = false
		for new_ability in new_abilities:
			# TODO: Testear bien esto
			if ability.ability_name == new_ability.ability_name:
				ability_on_next_phase = true
				
		ability.boss_phase_changed(ability_on_next_phase)
	
	abilities = new_abilities
	
	for ability in abilities:
		ability.boss = boss
