class_name AzraelPhase2 extends BossPhase

func condition_to_next_phase() -> bool:
	return boss.health < boss.max_health * 0.1

func enter() -> void:
	# Passives
	change_passives(passives_enter, true)
	
	# Abilities
	change_abilities(abilities)

func update(delta: float) -> void:
	if condition_to_next_phase():
		emit_signal("finished", "Phase3")

func exit() -> void:
	# Passives
	change_passives(passives_exit, false)
