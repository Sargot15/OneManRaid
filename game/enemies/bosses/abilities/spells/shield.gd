extends Node2D

signal shield_destroyed

@export var shield_life : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func take_damage(damage : float):
	shield_life -= damage
	FloatingTextManager.show_damage_shield_text(damage, global_position)
	
	if (shield_life <= 0):
		shield_destroyed.emit()
