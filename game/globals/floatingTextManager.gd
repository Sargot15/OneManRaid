extends Node

var FloatingTextScene := preload("res://game/utils/floatingText.tscn")

const DAMAGE_COLOR : Color = Color.RED
const DAMAGE_SHIELD_COLOR : Color = Color.CADET_BLUE
const HEAL_COLOR : Color = Color.GREEN

func show_damage_text(amount : int, world_position : Vector2):
	show_text(amount, world_position, DAMAGE_COLOR)

func show_damage_shield_text(amount : int, world_position : Vector2):
	show_text(amount, world_position, DAMAGE_SHIELD_COLOR)

func show_heal_text(amount : int, world_position : Vector2):
	show_text(amount, world_position, HEAL_COLOR)

func show_text(amount : int, world_position : Vector2, color : Color):
	var text_instance = FloatingTextScene.instantiate()
	text_instance.text = " " + str(amount) + " " # Added spaces so the outline of the text shows correctly
	text_instance.global_position = world_position + Vector2(randf_range(-20, 20) - (text_instance.size.x / 2), randf_range(-20, 0))
	text_instance.text_color = color
	get_tree().current_scene.add_child(text_instance)

