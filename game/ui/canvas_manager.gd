class_name CanvasManager extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_hero_health_update(hero_type : Globals.COLOR_TYPE, health : float, max_health : float):
	if (hero_type == Globals.COLOR_TYPE.BLUE):
		$CanvasLayer/PanelHeroesInfo/PanelHeroBlue/HeroInfo/Stats/LifePanel.update_UI_health(health, max_health)
	if (hero_type == Globals.COLOR_TYPE.BROWN):
		$CanvasLayer/PanelHeroesInfo/PanelHeroBrown/HeroInfo/Stats/LifePanel.update_UI_health(health, max_health)
	if (hero_type == Globals.COLOR_TYPE.GREEN):
		$CanvasLayer/PanelHeroesInfo/PanelHeroGreen/HeroInfo/Stats/LifePanel.update_UI_health(health, max_health)
	if (hero_type == Globals.COLOR_TYPE.YELLOW):
		$CanvasLayer/PanelHeroesInfo/PanelHeroYellow/HeroInfo/Stats/LifePanel.update_UI_health(health, max_health)


func _on_hero_stats_updated(hero_type : Globals.COLOR_TYPE, def : float, att : float, spd : float, att_range : float, att_speed : float):
	if (hero_type == Globals.COLOR_TYPE.BLUE):
		$CanvasLayer/PanelHeroesInfo/PanelHeroBlue/HeroInfo/Stats/StatsTexts.update_stats(def, att, spd, att_range, att_speed)
	if (hero_type == Globals.COLOR_TYPE.BROWN):
		$CanvasLayer/PanelHeroesInfo/PanelHeroBrown/HeroInfo/Stats/StatsTexts.update_stats(def, att, spd, att_range, att_speed)
	if (hero_type == Globals.COLOR_TYPE.GREEN):
		$CanvasLayer/PanelHeroesInfo/PanelHeroGreen/HeroInfo/Stats/StatsTexts.update_stats(def, att, spd, att_range, att_speed)
	if (hero_type == Globals.COLOR_TYPE.YELLOW):
		$CanvasLayer/PanelHeroesInfo/PanelHeroYellow/HeroInfo/Stats/StatsTexts.update_stats(def, att, spd, att_range, att_speed)



func _on_debug_enable_spawners_pressed():
	for s in $"../Spawners".get_children():
		if (s.enabled):
			s.disable()
		else:
			s.enable()
