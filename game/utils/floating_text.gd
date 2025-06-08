class_name FloatingText extends RichTextLabel

@export var float_speed : float = 50.0
@export var duration : float = 1.0
@export var text_color : Color = Color.WHITE

@onready var alive_timer : Timer = $AliveTimer

var velocity : Vector2 = Vector2.UP


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 1.0
	add_theme_color_override("default_color", text_color)
	
	velocity *= float_speed

	alive_timer.wait_time = duration
	alive_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	modulate.a -= delta / duration

func _on_alive_timer_timeout():
	queue_free()
