extends Node2D

@export var speed : float = 400
@export var damage : float
@export var type : Globals.COLOR_TYPE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta
	

func _on_kill_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if(body.has_method("take_damage")):
		body.take_damage(damage)
		
	queue_free()
