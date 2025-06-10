class_name AzraelPhase3 extends BossPhase

@export var radius_movement : float = 400
@export var speed: float = 1.0

var center_position : Vector2
var angle: float = PI * 2 * (3.0 / 4.0)  # Actual angle, starts in the North

func enter() -> void:
	current_substate = PHASE_SUBSTATE.INTERMISSION
	center_position = boss.global_position
	
	# Stop all active abilities
	stop_abilities()
	
	# Initial movement of the boss in this phase
	var target_position : Vector2 = center_position + Vector2(0, -radius_movement)
	var tween_initial_movement : Tween = create_tween()
	tween_initial_movement.tween_property(boss, "global_position", target_position, 2.0)
	tween_initial_movement.tween_callback(_start_phase_behaviour)
	
func _start_phase_behaviour() -> void:
	# Passives
	change_passives(passives_enter, true)
	
	# Abilities
	change_abilities(abilities)
	start_abilities()
	
	current_substate = PHASE_SUBSTATE.ACTIVE

func update_physics(delta: float) -> void:
	match current_substate:
		PHASE_SUBSTATE.ACTIVE:
			# Movement
			angle += speed * delta
			if angle > 2 * PI:
				angle -= PI * 2
			var offset = Vector2(cos(angle), sin(angle)) * radius_movement
			boss.global_position = center_position + offset

func exit() -> void:
	# Passives
	change_passives(passives_exit, false)
