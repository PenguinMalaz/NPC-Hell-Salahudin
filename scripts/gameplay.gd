extends Control

@export var player : Node2D

@export var fps : Label
@export var coin : Label
@export var health : Label
@export var top : Label

var coin_collected : int
var current_health : int

func _ready() -> void:
	Score.top_coin = load_top_coin()
	pass

func load_top_coin() -> int:
	var config = ConfigFile.new()
	if config.load("user://save.cfg") == OK:
		return config.get_value("score", "top_coin", 0)
	return 0

func save_high_score(score: int):
	var config = ConfigFile.new()
	config.set_value("score", "top_coin", score)
	config.save("user://save.cfg")

func _process(delta: float) -> void:
	fps.text = "fps: " + str(Engine.get_frames_per_second())
	
	if player:
		coin_collected = player.coin_collected
		current_health = player.current_health
	else:
		current_health = 0
	
	coin.text = str(coin_collected)
	health.text = str(current_health)
	
	Score.coin = coin_collected
	
	if Score.coin > Score.top_coin:
		save_high_score(Score.coin)
		Score.top_coin = Score.coin
		top.visible = true
