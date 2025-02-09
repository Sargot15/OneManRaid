extends Area2D

@export var speed : float = 400

@onready var timerAlive = $TimeAlive

var damage : float

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
	
func set_damage(dam : float):
	damage = dam

func _on_time_alive_timeout():
	queue_free()


func _on_body_entered(body):
	if(body.has_method("take_damage")):
		body.take_damage(damage)
		
	queue_free()
