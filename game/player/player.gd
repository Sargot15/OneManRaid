class_name Player extends CharacterBody2D

signal hero_health_update(hero_type : Globals.COLOR_TYPE, health : int, max_health : int)
signal stats_updated(hero_type : Globals.COLOR_TYPE ,def : float, att : float, spd : float, att_range : float, att_speed : float)

@export var heroes : Array[Node2D]

var direction = Vector2.ZERO
var actual_hero : Node2D
var actual_hero_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	actual_hero = heroes[actual_hero_index]
	actual_hero.visible = true
	Globals.set_player(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_move_player(delta)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		actual_hero.shoot()
	
	# Var to change hero in case the key is pressed
	var new_hero_index = -1
	
	if Input.is_key_pressed(KEY_1):
		new_hero_index = 0
	if Input.is_key_pressed(KEY_2):
		new_hero_index = 1
	if Input.is_key_pressed(KEY_3):
		new_hero_index = 2
	if Input.is_key_pressed(KEY_4):
		new_hero_index = 3
		
	if (new_hero_index != -1 && new_hero_index != actual_hero_index):
		_change_hero(new_hero_index)
	
func _move_player(delta) -> void:
	var speed = actual_hero.get_speed()
	# Detect movement by keys
	direction.x = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
	direction.y = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))
	
	# Detect movement by mouse (mouse is priorized)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		direction.x = int(get_global_mouse_position().x - global_position.x)
		direction.y = int(get_global_mouse_position().y - global_position.y)
		
		# If mouse is very close to the mouse the speed is slower so the player is not "dancing" around the mouse
		var distance_to_mouse = global_position.distance_to(get_global_mouse_position())
		if distance_to_mouse < speed * delta:
			speed = distance_to_mouse / delta
	
	velocity = velocity.lerp(direction.normalized() * speed, 1.0 - exp(-15 * delta))
	
	move_and_slide()
	
# Tries to change the hero, returns true it is possible, false if it is not
func _change_hero(new_hero_index: int) -> bool:
	if heroes[new_hero_index].is_alive():
		actual_hero_index = new_hero_index
		actual_hero.visible = false
		actual_hero = heroes[actual_hero_index]
		actual_hero.visible = true
		return true
	else:
		return false
	
func take_damage(damage : float, color_type : Globals.COLOR_TYPE) -> void:
	actual_hero.take_damage(damage, color_type)
	
	# Actual hero is dead, change to next alive hero
	if not actual_hero.is_alive():
		for i in range(heroes.size()):
			if _change_hero((actual_hero_index + i) % heroes.size()):
				break
				
		# No heroes alive, game over
		if not actual_hero.is_alive():
			# TODO: GAME OVER
			pass	

func _on_hero_health_updated(hero_type, health, max_health):
	hero_health_update.emit(hero_type, health, max_health)
	
func _on_hero_stats_updated(hero_type, def, att, spd, att_range, att_speed):
	stats_updated.emit(hero_type, def, att, spd, att_range, att_speed)
	
