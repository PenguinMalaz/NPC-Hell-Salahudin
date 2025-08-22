extends Node2D

var player_exist : bool = false
@export var player : Node2D
@export var game_over_menu : PackedScene

func _process(delta: float) -> void:
	if not player_exist and not player:
		print("free!")
		player_exist = true
		game_over()
	
	if Global.difficulty == "normal":
		$spawn_enemy/spawn_timer.wait_time = 1.5
	elif Global.difficulty == "hard":
		$spawn_enemy/spawn_timer.wait_time = 0.5
	else:
		$spawn_enemy/spawn_timer.wait_time = 2
	

func game_over():
	var go_game_over = game_over_menu.instantiate()
	MusicManager.gameover()
	add_child(go_game_over)
	return
