class_name MorganthPhase4 extends BossPhase

func enter() -> void:
	# Passives
	change_passives(passives_enter, true)
	
	# Abilities
	change_abilities(abilities)
	
	# Movement
	movement_controller.set_idle()

func exit() -> void:
	# Passives
	change_passives(passives_exit, false)
