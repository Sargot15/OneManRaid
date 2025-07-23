class_name PhaseManager extends Node

@export var initial_phase: BossPhase
@export var boss : Boss
@export var ability_caster : AbilityCaster
@export var movement_contrller : MovementController

var phases_map := {}
var current_phase: BossPhase = null
var previous_phase: BossPhase = null

func _ready():
	for child in get_children():
		if child is BossPhase:
			phases_map[child.name] = child
			child.phase_manager = self
			child.boss = boss
			child.ability_caster = ability_caster
			child.movement_controller = movement_contrller
			child.finished.connect(change_phase)
	
	if initial_phase:
		change_phase(initial_phase.name)

func _process(delta):
	if current_phase:
		current_phase.update(delta)
		
func _physics_process(delta):
	if current_phase:
		current_phase.update_physics(delta)

func change_phase(phase_name: String) -> void:
	if not phases_map.has(phase_name):
		return
	
	if current_phase:
		current_phase.exit()
		previous_phase = current_phase
	
	current_phase = phases_map[phase_name]
	current_phase.enter()
	
	#emit_signal("state_changed", previous_state, current_state)
