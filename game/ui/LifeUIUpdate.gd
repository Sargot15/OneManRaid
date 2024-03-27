extends Panel

@export var hero : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_UI_health(health : int, max_health : int):
	$TextureProgressBar/ActualLife.text = "[center][b]" + str (health) + "[/b][/center]"
	$TextureProgressBar/MaxLife.text = "[center][b]" + str (max_health) + "[/b][/center]"

	$TextureProgressBar.value = health * 100 / max_health
