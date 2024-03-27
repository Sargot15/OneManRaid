extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_hero_health_update(hero_type, health, max_health):
	if (hero_type == Globals.COLOR_TYPE.BLUE):
		$CanvasLayer/PanelHeroesInfo/PanelHeroBlue/HeroInfo/Stats/LifePanel.update_UI_health(health, max_health)
	if (hero_type == Globals.COLOR_TYPE.BROWN):
		$CanvasLayer/PanelHeroesInfo/PanelHeroBrown/HeroInfo/Stats/LifePanel.update_UI_health(health, max_health)
	if (hero_type == Globals.COLOR_TYPE.GREEN):
		$CanvasLayer/PanelHeroesInfo/PanelHeroGreen/HeroInfo/Stats/LifePanel.update_UI_health(health, max_health)
	if (hero_type == Globals.COLOR_TYPE.YELLOW):
		$CanvasLayer/PanelHeroesInfo/PanelHeroYellow/HeroInfo/Stats/LifePanel.update_UI_health(health, max_health)
