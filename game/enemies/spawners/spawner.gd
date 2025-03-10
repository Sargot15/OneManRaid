extends Node2D

#------------------------------------
# REFERENCES
#------------------------------------
@onready var shoot_timer = $ShootTimer
@onready var change_bullet_timer = $ChangeBulletTimer
@onready var time_alive_timer = $TimeAliveTimer
@onready var bullet_start_hitting_timer = $BulletsStartHittingTimer
@onready var time_to_restart_timer = $TimeToRestartTimer

@onready var rotater = $Rotater
@onready var spawner_points = $SpawnerPoints

@onready var pattern_angle = $ShootPatterns/Angle
@onready var pattern_equally_distributed = $ShootPatterns/EquallyDistributed
@onready var pattern_one_direction = $ShootPatterns/OneDirection


#------------------------------------
# EXPORT VARIABLES
#------------------------------------
@export var enabled : bool = true
@export var spawn_point_count : int
@export var bullet_types : Array[PackedScene]
@export_range(0.01, 100) var shooting_time : float
## Time in seconds to change bullet's type. If the value is 0 then the bullet type it is going to be always the same
@export var change_bullet_time : float
@export var time_alive : float
## Time in seconds to restart the spawner after it is dead
@export var time_to_restart : float = -1

@export_subgroup("Static bullets")
@export var has_static_bullets : bool = false
@export var sb_bullets_per_spawn : int = 1

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

@export_category("Bullets modifiers")
@export var bullet_speed : float = -1
@export var bullet_damage : float = -1
@export var bullet_time_alive : float = -1
@export var bullet_max_distance : float = -1
@export var bullet_time_to_start_hit : float = -1

#------------------------------------
# LOCAL VARIABLES
#------------------------------------
var bullet_scene : PackedScene

#------------------------------------
# INITIALIZATION FUNCTIONS
#------------------------------------

# Called when the node enters the scene tree for the first time.
func _ready():
	if (enabled):
		initialize_components()


func initialize_components():
	
	# Set first bullet
	bullet_scene = bullet_types.pick_random()
	
	# If it is set to the bullets start hitting player after some time we initialize the timer
	if (bullet_time_to_start_hit > 0):
		bullet_start_hitting_timer.wait_time = bullet_time_to_start_hit
		bullet_start_hitting_timer.start()
	
	# Set pattern
	initialize_pattern()
	
	if (has_static_bullets):
		initialize_static_bullets()
		shoot_timer.stop()
	else:
		#Set timers
		set_shoot_timer(shooting_time)
		if (change_bullet_time > 0):
			set_change_bullet_timer(change_bullet_time)
	
	# Behaviours
	if (rotation_enabled):
		rotater.initialize(rotation_speed)
		
	if (time_alive > 0):
		time_alive_timer.wait_time = time_alive
		time_alive_timer.start()


func initialize_pattern():
	if (shoot_pattern == ShootPattern.ANGLE):
		pattern_angle.initialize_pattern(angle_direction, angle_arc, angle_radius, spawn_point_count)
	elif (shoot_pattern == ShootPattern.ONE_DIRECTION):
		pattern_one_direction.initialize_pattern(od_direction, od_bullet_separation, spawn_point_count)
	elif (shoot_pattern == ShootPattern.EQUALLIY_DISTRIBUTED):
		pattern_equally_distributed.initialize_pattern(ed_radius, spawn_point_count)
	else:
		pass

func initialize_static_bullets():
	for s in spawner_points.get_children():
		for i in sb_bullets_per_spawn:
			var bullet = bullet_scene.instantiate()
			s.add_child(bullet)
			bullet.position.x += i * 20 #TODO: Make that '20' an export var
			bullet.is_static = true
			bullet.set_time_alive(0)
			apply_bullet_modifiers(bullet)

func set_shoot_timer(shooting_time : float):
	shoot_timer.stop()
	shoot_timer.wait_time = shooting_time
	shoot_timer.start()


func set_change_bullet_timer(change_bullet_time : float):
	change_bullet_timer.stop()
	change_bullet_timer.wait_time = change_bullet_time
	change_bullet_timer.start()
	
func enable():
	if (!enabled):
		# initialize components again
		initialize_components()
		
		enabled = true
	
func disable():
	if (enabled):
		# stop all timers
		shoot_timer.stop()
		change_bullet_timer.stop()
		time_alive_timer.stop()
		
		# remove all the spawner points
		for s in spawner_points.get_children():
			s.queue_free()
		
		enabled = false
		
func apply_bullet_modifiers(bullet):
	if (bullet_speed != -1):
		bullet.speed = bullet_speed
	if (bullet_damage != -1):
		bullet.damage = bullet_damage
	if (bullet_max_distance != -1):
		bullet.max_distance = bullet_max_distance
	if (bullet_time_alive != -1):
		bullet.set_time_alive(bullet_time_alive)
	if (bullet_time_to_start_hit != -1):
		bullet.set_time_start_hitting(bullet_start_hitting_timer.time_left)

#------------------------------------
# TIMERS
#------------------------------------
func _on_shoot_timer_timeout():
	for s in spawner_points.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
		apply_bullet_modifiers(bullet)


func _on_change_bullet_timer_timeout():
	bullet_scene = bullet_types.pick_random()

func _on_time_alive_timer_timeout():
	# If the timer has a time to restart we initialize the timer. Else, destroy the spawners
	if (time_to_restart >= 0):
		time_to_restart_timer.wait_time = time_to_restart
		time_to_restart_timer.start()
		disable()
	else:
		queue_free()
		
func _on_time_to_restart_timer_timeout():
	time_to_restart_timer.stop()
	enable()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
