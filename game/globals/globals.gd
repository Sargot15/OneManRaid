extends Node

enum COLOR_TYPE {YELLOW, BLUE, BROWN, GREEN, GRAY}

var debug_total_enemy_bullets : int = 0

var player: Node = null

func set_player(p):
	player = p

func get_player_position() -> Vector2:
	if player:
		return player.global_position
	return Vector2.ZERO
