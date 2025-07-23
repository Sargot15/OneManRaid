class_name AzraelPhase3 extends BossPhase

@export var radius_movement : float = 400
@export var speed_intermission : float = 200.0
@export var speed_phase : float = 1.0

var center_position : Vector2
var target_position_intermission : Vector2
var angle: float = PI * 2 * (3.0 / 4.0)  # Actual angle, starts in the North

func enter() -> void:
	current_substate = PHASE_SUBSTATE.INTERMISSION
	center_position = boss.global_position
	
	# Stop all active abilities
	stop_abilities()
	
	# Initial movement of the boss in this phase
	target_position_intermission = center_position + Vector2(0, -radius_movement)
	
	# Set movement
	movement_controller.set_normal_movement(func(delta): _intermission_movement(delta))


func _start_phase_behaviour() -> void:
	# Passives
	change_passives(passives_enter, true)
	
	# Abilities
	change_abilities(abilities)
	start_abilities()
	
	# Set movement
	movement_controller.set_normal_movement(func(delta): _phase_movement(delta))
	
	current_substate = PHASE_SUBSTATE.PHASE


func update_physics(delta: float) -> void:
	# Check if we have to change from intermission to phase
	if current_substate == PHASE_SUBSTATE.INTERMISSION and boss.global_position.distance_to(target_position_intermission) < 1:
		_start_phase_behaviour()


func _intermission_movement(delta: float) -> void:
	boss.global_position = boss.global_position.move_toward(target_position_intermission, speed_intermission * delta)


func _phase_movement(delta: float) -> void:
	angle += speed_phase * delta
	if angle > 2 * PI:
		angle -= PI * 2
	var offset = Vector2(cos(angle), sin(angle)) * radius_movement
	boss.global_position = center_position + offset


func exit() -> void:
	# Passives
	change_passives(passives_exit, false)
