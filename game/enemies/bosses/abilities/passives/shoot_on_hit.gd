class_name ShootOnHit extends Node

@export var boss : Boss
@export var spawner : Spawner


var is_activated : bool = false

func activate() -> void:
	# Connect the is_hit boss signal to create the butllet
	boss.connect("is_hit", _on_boss_hit)
	
	is_activated = true
	
func deactivate() -> void:
	if is_activated:
		boss.disconnect("is_hit", _on_boss_hit)
	
	is_activated = false

func _on_boss_hit(damage_type : Globals.COLOR_TYPE) -> void:
	spawner.change_bullet_random(damage_type)
	spawner.shoot()
