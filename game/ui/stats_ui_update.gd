class_name StatsUIUpdate extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_stats(def : float, att : float, spd : float, att_range : float, att_speed : float) -> void:
	$Attack.text = "ATT: " + str(int(att))
	$Defense.text = "DEF: " + str(int(def))
	$Speed.text = "SPD: " + str(int(spd))
	$AttackRange.text = "RAN: " + str(int(att_range))
	$AttackSpeed.text = "ATS: " + str(int(att_speed))
	
