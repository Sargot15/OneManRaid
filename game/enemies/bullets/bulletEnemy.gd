extends Node2D

const speed = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta
	

func _on_kill_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if(body.has_method("take_damage")):
		body.take_damage()
		
	queue_free()
