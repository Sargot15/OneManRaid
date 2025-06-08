class_name AzraelPhase3 extends BossPhase

func enter() -> void:
	# Passives
	change_passives(passives_enter, true)
	
	# Abilities
	change_abilities(abilities)

func update(delta: float) -> void:
	pass

func exit() -> void:
	# Passives
	change_passives(passives_exit, true)
