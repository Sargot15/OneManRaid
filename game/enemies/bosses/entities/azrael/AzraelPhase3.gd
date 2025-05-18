class_name AzraelPhase3 extends BossPhase

func enter():
	print("Entrando en Fase 3")
	# Passives
	change_passives(passives_enter, true)
	
	# Abilities
	change_abilities(abilities)

func update(delta: float):
	pass

func exit():
	print("Saliendo de Fase 3")
	# Passives
	change_passives(passives_exit, true)
