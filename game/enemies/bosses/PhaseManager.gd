class_name PhaseManager extends Node


@export var initial_phase: BossPhase
@export var boss : Boss
@export var ability_caster : AbilityCaster

var phases_map := {}
var current_phase: BossPhase = null
var previous_phase: BossPhase = null

func _ready():
	for child in get_children():
		if child is BossPhase:
			phases_map[child.name] = child
			child.phase_manager = self
			child.finished.connect(change_phase)
			child.boss = boss
			child.ability_caster = ability_caster
	
	if initial_phase:
		change_phase(initial_phase.name)

func change_phase(phase_name: String):
	if not phases_map.has(phase_name):
		return
	
	if current_phase:
		current_phase.exit()
		previous_phase = current_phase
	
	current_phase = phases_map[phase_name]
	current_phase.enter()
	
	#emit_signal("state_changed", previous_state, current_state)

func _process(delta):
	if current_phase:
		current_phase.update(delta)
