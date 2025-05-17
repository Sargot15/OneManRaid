class_name AzraelPhase1 extends BossPhase

func condition_to_next_phase() -> bool:
	return boss.health < boss.max_health * 0.6

func enter():
	# Passives
	var passives: Array[Node] = [
		boss.get_node("Passives/SpawnersFixedFullFight"),
		boss.get_node("Passives/SpawnersFixedPhase1")
	]
	
	change_passives(passives, true)
	
	# Abilities
	var abilities : Array[Node] = [
		ability_caster.get_node("Abilities/TheHunt"),
		ability_caster.get_node("Abilities/TurtleMode")
	]
	
	change_abilities(abilities)

func update(delta: float):
	if condition_to_next_phase():
		emit_signal("finished", "Phase2")

func exit():
	# Passives
	var passives: Array[Node] = [
		boss.get_node("Passives/SpawnersFixedPhase1")
	]	
	
	change_passives(passives, false)
