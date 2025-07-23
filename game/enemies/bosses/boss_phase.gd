class_name BossPhase extends Node

signal finished(next_state_name)

enum PHASE_SUBSTATE { INTERMISSION, PHASE }

@export var passives_enter : Array[Node] # Passives to activate at entering the phase
@export var passives_exit : Array[Node] # Passives to deactivate at exiting the phase
@export var abilities : Array[Node] # Abilities that can be casted during this phase

# References
var boss : Boss = null
var phase_manager: PhaseManager = null
var ability_caster : AbilityCaster = null
var movement_controller : MovementController = null

var current_substate : PHASE_SUBSTATE = PHASE_SUBSTATE.INTERMISSION

func enter():
	pass

func exit():
	pass

func update(delta: float) -> void:
	pass
	
func update_physics(delta: float) -> void:
	pass
	
func condition_to_next_phase() -> bool:
	return false
	
func change_passives(passives : Array[Node], activate : bool) -> void:
	if activate:
		for passive in passives:
			if passive and passive.has_method("activate"):
				passive.activate()
	else:
		for passive in passives:
			if passive and passive.has_method("deactivate"):
				passive.deactivate()

func change_abilities(abilities : Array[Node]) -> void:
	if ability_caster:
		ability_caster.change_abilities(abilities)
		
func stop_abilities() -> void:
	if ability_caster:
		ability_caster.stop()
		
func start_abilities() -> void:
	if ability_caster:
		ability_caster.start()
