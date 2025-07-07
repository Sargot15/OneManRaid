class_name DamageAreaPassive extends Node

@export var boss : Boss

@export var damage_area_scene: PackedScene
@export var damage_areas : Array[DamageAreaConfig]

var is_activated : bool = false

var active_areas : Array[DamageArea]

func activate() -> void:
	for damage_area_config in damage_areas:
		var area = damage_area_scene.instantiate() as DamageArea
		add_child(area)
		
		# Set area position
		var initial_pos = Vector2.ZERO
		if damage_area_config.pos_relative_to_boss:
			initial_pos = boss.global_position
		var offset_x : float = randf_range(damage_area_config.pos_random_x_left_range, damage_area_config.pos_random_x_right_range)
		var offset_y : float = randf_range(damage_area_config.pos_random_y_top_range, damage_area_config.pos_random_y_bottom_range)
		area.global_position = initial_pos + Vector2(offset_x, offset_y)
			
		area.config_area_damage(damage_area_config)
		area.connect("area_destroyed", _on_damage_area_destroyed)
		active_areas.append(area)
		
	is_activated = true
	
func deactivate() -> void:
	var areas_to_destroy : Array[DamageArea]
	
	for area in active_areas:
		areas_to_destroy.append(area)
		
	for area in areas_to_destroy:
		area.destroy()

func _on_damage_area_destroyed(area: DamageArea):
	active_areas.erase(area)
