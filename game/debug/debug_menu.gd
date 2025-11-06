class_name DebugMenu extends CanvasLayer

@onready var add_area_btn = $PanelContainer/VBoxContainer/AddAreaButton
@onready var add_area_config_popup =$PanelContainer/AddAreaConfigPopUp
@onready var resource_editor = $PanelContainer/AddAreaConfigPopUp/ScrollContainer/VBoxContainer/ResourceEditor

func _input(event):
	if event.is_action_pressed("ui_debug_menu"):
		visible = !visible

func _on_add_area_button_pressed():
	var cfg = DamageAreaConfig.new()
	resource_editor.set_resource(cfg)
	add_area_config_popup.popup_centered()


func _on_create_area_button_pressed():
	var area_scene = preload("res://game/enemies/areas/damage_area.tscn")
	var new_area = area_scene.instantiate() as DamageArea
	
	new_area.config_area_damage(resource_editor.target_resource)
	
	get_tree().get_current_scene().add_child(new_area)
	new_area.global_position = get_viewport().get_mouse_position()
	
	add_area_config_popup.hide()
