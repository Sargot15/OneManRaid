class_name ExplosiveAreaOnHit extends Node

@export var boss : Boss

@export var explosive_area_scene: PackedScene
@export var explosive_area_config : ExplosiveAreaConfig

var is_activated : bool = false

func activate() -> void:
	# Connect the is_hit boss signal to create the area
	boss.connect("is_hit", _on_boss_hit)
	
	is_activated = true
	
func deactivate() -> void:
	if is_activated:
		boss.disconnect("is_hit", _on_boss_hit)
	
	is_activated = false

func _on_boss_hit(damage_type : Globals.COLOR_TYPE) -> void:
	var area = explosive_area_scene.instantiate() as ExplosiveArea
	add_child(area)

	area.global_position = Globals.get_player_position()

	area.config_area_explosive(explosive_area_config)
