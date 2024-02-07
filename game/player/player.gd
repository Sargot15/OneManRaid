extends CharacterBody2D

@export var speed = 300
@export var heroes : Array[Node2D]

var direction = Vector2.ZERO
var actual_hero : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	actual_hero = heroes[0]
	actual_hero.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_player()
	
	if (Input.is_key_pressed(KEY_1)):
		change_hero(0)
	if (Input.is_key_pressed(KEY_2)):
		change_hero(1)
	if (Input.is_key_pressed(KEY_3)):
		change_hero(2)
	if (Input.is_key_pressed(KEY_4)):
		change_hero(3)
	
func move_player():
	direction.x = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
	direction.y = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))
	
	velocity = direction.normalized() * speed
	
	move_and_slide()
	
func change_hero(index: int):
	actual_hero.visible = false
	actual_hero = heroes[index]
	actual_hero.visible = true
	
