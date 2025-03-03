extends "res://game/enemies/bosses/boss.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	start_phase_1()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Check if transition to next phase
	if (health < max_health * 0.5 and actual_phase == 1):
		finish_phase_1()
		start_phase_2()

func start_phase_1():
	print("starting phase 1")
	#Passives
	$Passives/SpawnersFixedFullFight.activate()
	$Passives/SpawnersFixedPhase1.activate()
	
	#Set phase
	actual_phase = 1
	
func finish_phase_1():
	print("finishing phase 1")
	#Passives
	$Passives/SpawnersFixedPhase1.deactivate()
	
func start_phase_2():
	print("starting phase 2")
	#Passives
	$Passives/SpawnersFixedPhase2.activate()
	
	#Set phase
	actual_phase = 2
