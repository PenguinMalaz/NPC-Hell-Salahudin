extends Node2D

@export var spawn_enemy : Node2D
@export var spawn_timer : Timer

@export var spawn_area : Vector2
@export var coin_scene : PackedScene
@export var coin_container : Node2D

var spawn_rate: float = 2.0
var min_spawn_rate: float = 0.5
var spawn_decrease: float = 0.1

var coin_exist : bool = false

signal add_spawner

func _process(delta: float) -> void:
	if not coin_exist and get_tree().get_nodes_in_group("coin").size() == 0:
		coin_exist = true
		await get_tree().create_timer(1.0).timeout
		spawn_coin()
		spawn_enemy._add_spawner()
		spawn_rate = max(spawn_rate - spawn_decrease, min_spawn_rate)
		spawn_timer.wait_time = spawn_rate
		spawn_timer.start()
		coin_exist = false

func spawn_coin():
	var x = randf_range(20, 460)
	var y = randf_range(50, 660)
	var spawn_pos = Vector2(x, y)
	
	var coin = coin_scene.instantiate()
	coin.position = spawn_pos
	
	coin_container.add_child(coin)
