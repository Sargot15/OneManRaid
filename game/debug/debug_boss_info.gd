class_name DebugBossInfo extends CanvasLayer

@onready var phase_manager : PhaseManager = $"../PhaseManager"
@onready var ability_caster : AbilityCaster = $"../AbilitiesCaster"
@onready var passives : Node = $"../Passives"

@onready var phase_label : Label = $BoxContainer/PhaseLabel
@onready var passives_container : VBoxContainer = $BoxContainer/VBoxContainer/Passives
@onready var abilities_container : VBoxContainer = $BoxContainer/VBoxContainer/Abilities

var abilities_casting : Array[BossAbility]

# Called when the node enters the scene tree for the first time.
func _ready():
	if not OS.is_debug_build():
		queue_free()
		return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if phase_manager and phase_manager.current_phase:
		phase_label.text = "Phase: " + str(phase_manager.current_phase.name)
		
	if passives and passives.get_children().size() > 0:
		for passive in passives.get_children():
			if passive.is_activated:
				var was_active := false
				for label in passives_container.get_children():
					if label.text == passive.name:
						was_active = true
				if not was_active:
					var new_passive = Label.new()
					new_passive.text = passive.name
					passives_container.add_child(new_passive)
			else:
				for label in passives_container.get_children():
					if label.text == passive.name:
						passives_container.remove_child(label)
						
	if ability_caster and ability_caster.abilities and ability_caster.abilities.size() > 0:
		for ability in ability_caster.abilities:
			if ability.is_casting:
				var was_active := false
				for label in abilities_container.get_children():
					if label.text == ability.name:
						was_active = true
				if not was_active:
					abilities_casting.append(ability)
					var new_ability = Label.new()
					new_ability.text = ability.name
					abilities_container.add_child(new_ability)
			else:
				for label in abilities_container.get_children():
					if label.text == ability.name:
						abilities_container.remove_child(label)
						abilities_casting.erase(ability)
	# An ability can be still casting but not in the ability_caster.abilities becasuse of a change phase
	for ability in abilities_casting:
		if not ability.is_casting:
			for label in abilities_container.get_children():
				if label.text == ability.name:
					abilities_container.remove_child(label)
			abilities_casting.erase(ability)
