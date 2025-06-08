class_name BossPhase extends Node

signal finished(next_state_name)

@export var passives_enter : Array[Node] #Passives to activate at entering the phase
@export var passives_exit : Array[Node] #Passives to deactivate at exiting the phase
@export var abilities : Array[Node] #Abilities that can be casted during this phase

var phase_manager: PhaseManager = null
var boss : Boss = null
var ability_caster : AbilityCaster = null

func enter():
	pass

func exit():
	pass

func update(delta: float) -> void:
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
