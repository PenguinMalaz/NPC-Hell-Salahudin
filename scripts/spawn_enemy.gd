extends Node2D

@export var enemy_scene : PackedScene
@export var spawn_area : Vector2

@export var spawn_timer : Timer
@export var enemy_container : Node2D
@export var coin_spawner : Node2D

func _ready():
	if coin_spawner:
		coin_spawner.connect("add_spawner", Callable(self, "_on_add_spawner"))

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	
func _process(delta: float) -> void:
	return
	
func spawn_enemy():
	var x = [-20, 500].pick_random()
	var y = randf_range(0, spawn_area.y)
	var spawn_pos = Vector2(x, y)
	
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn_pos
	enemy_container.add_child(enemy)
	enemy.start_moving()

func _add_spawner():
	# Timer baru untuk menambah spawn musuh
	var new_timer = Timer.new()
	new_timer.wait_time = spawn_timer.wait_time
	new_timer.autostart = true
	new_timer.one_shot = false
	new_timer.timeout.connect(spawn_enemy)
	add_child(new_timer)
