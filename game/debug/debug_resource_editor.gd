class_name DebugResourceEditor extends VBoxContainer

var target_resource: Resource

var enum_options := {
	"area_shape": ["CIRCLE", "CIRCLE_INCOMPLETE", "CIRCLE_INVERTED", "CUSTOM"],
}

func set_resource(res: Resource):
	target_resource = res
	_clear()
	_build_ui_from_resource()

func _clear() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()

func _build_ui_from_resource():
	for prop in target_resource.get_property_list():
		# we only want the Export vars
		if not (prop.usage & PROPERTY_USAGE_EDITOR):
			continue
		if prop.name in ["resource_path", "resource_name", "script"]:
			continue

		var name = prop.name
		var type = prop.type
		var value = target_resource.get(name)

		var label = Label.new()
		label.text = name.capitalize()
		add_child(label)

		var control
		
		if enum_options.has(name):
			control = OptionButton.new()
			var options = enum_options[name]
			for i in options.size():
				control.add_item(options[i])
			control.selected = clamp(int(value), 0, options.size() - 1)
			control.connect("item_selected", func(i):
				target_resource.set(name, i))
			add_child(control)
			continue
		
		match type:
			TYPE_INT, TYPE_FLOAT:
				control = SpinBox.new()
				control.value = value
				if type == TYPE_INT:
					control.step = 1
				else:
					control.step = 0.1
				control.connect("value_changed", func(v): target_resource.set(name, v))
			
			TYPE_BOOL:
				control = CheckBox.new()
				control.button_pressed = value
				control.connect("toggled", func(v): target_resource.set(name, v))
			
			TYPE_STRING:
				control = LineEdit.new()
				control.text = value
				control.connect("text_changed", func(v): target_resource.set(name, v))
			
			TYPE_COLOR:
				control = ColorPickerButton.new()
				control.color = value
				control.connect("color_changed", func(v): target_resource.set(name, v))
			
			TYPE_INT | TYPE_FLOAT:
				# handled above
				pass

			_:
				# Enum o desconocido
				if prop.hint == PROPERTY_HINT_ENUM:
					control = OptionButton.new()
					var options = prop.hint_string.split(",")
					for i in options.size():
						control.add_item(options[i])
					control.selected = value
					control.connect("item_selected", func(i): target_resource.set(name, i))
				else:
					continue  # Saltar tipos no soportados

		if control:
			add_child(control)
