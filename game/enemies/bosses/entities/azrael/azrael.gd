class_name Azrael extends Boss


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_shield_shield_destroyed():
	print("shield destroyed")
