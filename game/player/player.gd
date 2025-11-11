class_name Player extends CharacterBody2D

signal hero_health_update(hero_type : Globals.COLOR_TYPE, health : int, max_health : int)
signal stats_updated(hero_type : Globals.COLOR_TYPE ,def : float, att : float, spd : float, att_range : float, att_speed : float)

@export var heroes : Array[Hero]

var direction = Vector2.ZERO
var actual_hero : Hero
var actual_hero_index : int = 0

var moving_by_mouse : bool = false

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
		
func _unhandled_input(event) -> void:
	# Detect movement by mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			moving_by_mouse = true
		else:
			moving_by_mouse = false
		
	# Detect change hero	
	if event.is_action_pressed("ui_change_hero_1"):
		_change_hero(0)
	if event.is_action_pressed("ui_change_hero_2"):
		_change_hero(1)
	if event.is_action_pressed("ui_change_hero_3"):
		_change_hero(2)
	if event.is_action_pressed("ui_change_hero_4"):
		_change_hero(3)
	
func _move_player(delta) -> void:
	var speed = actual_hero.get_speed()
	
	if moving_by_mouse:
		direction = get_global_mouse_position() - global_position
		
		# If mouse is very close to the mouse the speed is slower so the player is not "dancing" around the mouse
		var distance_to_mouse = global_position.distance_to(get_global_mouse_position())
		if distance_to_mouse < speed * delta:
			speed = distance_to_mouse / delta
	else:
		# Detect movement by keys
		direction.x = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
		direction.y = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))
		
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
	
