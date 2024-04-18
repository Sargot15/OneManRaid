extends Area2D

@export var speed : float = 400

@onready var timerAlive = $TimeAlive

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

func set_max_distance(max_distance : float):
	# Calculate how much time the bullet will be alive based on speed and max_distance
	timerAlive.wait_time = max_distance / speed
	timerAlive.start()

func _on_time_alive_timeout():
	queue_free()
