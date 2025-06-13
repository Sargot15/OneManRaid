class_name AbilityCaster extends Node

@export var boss : Boss
## At the beginning of the fight and just after casting an ability, this is the chance to cast another ability
@export_range(0, 1) var initial_chance_to_cast : float = 0
## Every time there is a try to cast an ability and it failed, the chance to cast an ability will increase this amount for the next try
@export_range(0, 1) var increased_chance_to_cast_after_try : float

var abilities : Array[Node]
var can_cast : bool = false
var actual_chance_to_cast : float

# Called when the node enters the scene tree for the first time.
func _ready():
	start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func start() -> void:
	if not can_cast:
		can_cast = true
		$TryCastAbilityTimer.start()
		actual_chance_to_cast = initial_chance_to_cast
	
func stop() -> void:
	if can_cast:
		can_cast = false
		$TryCastAbilityTimer.stop()
		
		# Stopping all active abilities
		for ability in abilities:
			ability.stop()

func change_abilities(new_abilities : Array[Node]) -> void:
	# Notice phase change to the old abilities
	for ability in abilities:
		
		# Search if this ability is part of the new abilities
		var ability_on_next_phase : bool = false
		for new_ability in new_abilities:
			if ability.ability_name == new_ability.ability_name:
				ability_on_next_phase = true
				
		ability.boss_phase_changed(ability_on_next_phase)
	
	abilities = new_abilities
	
	for ability in abilities:
		ability.boss = boss

func _on_ability_finished_cast():
	can_cast = true
	
func _on_try_cast_ability_timer_timeout():
	if not can_cast:
		return

	# Try to cast an ability
	actual_chance_to_cast += increased_chance_to_cast_after_try
	if randf() > actual_chance_to_cast:
		return

	var total_weight : float = 0
	
	for ability in abilities:
		if (ability.is_casteable):
			total_weight += ability.weight
	
	var pick = randf_range(0, total_weight)
	var accumulated_weight : float = 0
	
	for ability in abilities:
		if ability.is_casteable:
			accumulated_weight += ability.weight
			if pick < accumulated_weight:
				ability.cast()
				actual_chance_to_cast = initial_chance_to_cast
				if ability.is_unique_cast:
					can_cast = false
					ability.connect("finished_cast", _on_ability_finished_cast)
				break
