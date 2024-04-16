extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_stats(def : float, att : float, spd : float, att_range : float, att_speed : float):
	$Attack.text = "ATT: " + str(att)
	$Defense.text = "DEF: " + str(def)
	$Speed.text = "SPD: " + str(spd)
	$AttackRange.text = "RAN: " + str(att_range)
	$AttackSpeed.text = "ATS: " + str(att_speed)
	
