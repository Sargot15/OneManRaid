class_name AzraelPhase2 extends BossPhase

func condition_to_next_phase() -> bool:
	return boss.health < boss.max_health * 0.1

func enter():
	print("Entrando en Fase 2")
	
	# Passives
	var passives: Array[Node] = [
		boss.get_node("Passives/SpawnersFixedPhase2")
	]
	
	change_passives(passives, true)
	
	# Abilities
	var abilities : Array[Node] = [
		ability_caster.get_node("Abilities/TheHunt")
	]
	
	change_abilities(abilities)

func update(delta: float):
	if condition_to_next_phase():
		emit_signal("finished", "Phase3")

func exit():
	print("Saliendo de Fase 2")
