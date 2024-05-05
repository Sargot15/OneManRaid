extends Node2D

#------------------------------------
# REFERENCES
#------------------------------------
@onready var shoot_timer = $ShootTimer
@onready var change_bullet_timer = $ChangeBulletTimer
@onready var rotater = $Rotater
@onready var spawner_points = $SpawnerPoints
@onready var pattern_angle = $ShootPatterns/Angle
@onready var pattern_equally_distributed = $ShootPatterns/EquallyDistributed
@onready var pattern_one_direction = $ShootPatterns/OneDirection


#------------------------------------
# EXPORT VARIABLES
#------------------------------------
@export var spawn_point_count : int
@export var bullet_types : Array[PackedScene]
@export_range(0.01, 100) var shooting_time : float
## Time in seconds to change bullet's type. If the value is 0 then the bullet type it is going to be always the same
@export var change_bullet_time : float

@export_category("Shoot pattern")
enum ShootPattern {ANGLE, EQUALLIY_DISTRIBUTED, ONE_DIRECTION}
@export var shoot_pattern : ShootPattern

@export_subgroup("Angle")
## Distance from spawner's center for the bullet to instantiate. It can not be 0 beacause it causes problems when creating spawn points
@export_range(1, 1000) var angle_radius : float
## Average direction in grades of the angle to be shot: 0=E, 90=S, 180=W, 270=N
@export_range(0, 360) var angle_direction : float
## Size of the angle in grades. IE: 180 value will make half of the spawner to create bullets
@export_range(0, 360) var angle_arc : float

@export_subgroup("Equally distributed")
## Distance from spawner's center for the bullet to instantiate. It can not be 0 beacause it causes problems when creating spawn points
@export_range(1, 1000) var ed_radius : float

@export_subgroup("One direction")
## Direction in grades of the angle to be shot: 0=E, 90=S, 180=W, 270=N
@export_range(0, 360) var od_direction : float
## Distance between each bullet to be shot
@export var od_bullet_separation : float

@export_category("Behaviours")
@export_group("Rotation")
@export var rotation_enabled : bool
@export var rotation_speed : float

#------------------------------------
# LOCAL VARIABLES
#------------------------------------
var bullet_scene : PackedScene

#------------------------------------
# INITIALIZATION FUNCTIONS
#------------------------------------

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_components()


func initialize_components():
	#Set timers
	set_shoot_timer(shooting_time)
	if (change_bullet_time > 0):
		set_change_bullet_timer(change_bullet_time)
	
	# Set first bullet
	bullet_scene = bullet_types.pick_random()
	
	# Set pattern
	initialize_pattern()
		
	# Behaviours
	if (rotation_enabled):
		rotater.initialize(rotation_speed)
		
func initialize_pattern():
	if (shoot_pattern == ShootPattern.ANGLE):
		pattern_angle.initialize_pattern(angle_direction, angle_arc, angle_radius, spawn_point_count)
	elif (shoot_pattern == ShootPattern.ONE_DIRECTION):
		pattern_one_direction.initialize_pattern(od_direction, od_bullet_separation, spawn_point_count)
	elif (shoot_pattern == ShootPattern.EQUALLIY_DISTRIBUTED):
		pattern_equally_distributed.initialize_pattern(ed_radius, spawn_point_count)
	else:
		pass


func set_shoot_timer(shooting_time : float):
	shoot_timer.stop()
	shoot_timer.wait_time = shooting_time
	shoot_timer.start()


func set_change_bullet_timer(change_bullet_time : float):
	change_bullet_timer.stop()
	change_bullet_timer.wait_time = change_bullet_time
	change_bullet_timer.start()		

#------------------------------------
# TIMERS
#------------------------------------
func _on_shoot_timer_timeout():
	for s in spawner_points.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation


func _on_change_bullet_timer_timeout():
	bullet_scene = bullet_types.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
