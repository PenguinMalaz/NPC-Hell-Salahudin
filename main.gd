extends Node2D

@export var start : PackedScene

func _ready() -> void:
	load_volume()
	MusicManager.bgm()

func _process(delta: float) -> void:
	if Global.difficulty == "easy":
		$Control/difficulty/easy.self_modulate = Color(0.49, 1.0, 1.0)
		$Control/difficulty/normal.self_modulate = Color(1.0, 1.0, 1.0)
		$Control/difficulty/hard.self_modulate = Color(1.0, 1.0, 1.0)
	elif Global.difficulty == "normal":
		$Control/difficulty/easy.self_modulate = Color(1.0, 1.0, 1.0)
		$Control/difficulty/normal.self_modulate = Color(0.49, 1.0, 1.0)
		$Control/difficulty/hard.self_modulate = Color(1, 1.0, 1.0)
	elif Global.difficulty == "hard":
		$Control/difficulty/easy.self_modulate = Color(1.0, 1.0, 1.0)
		$Control/difficulty/normal.self_modulate = Color(1.0, 1.0, 1.0)
		$Control/difficulty/hard.self_modulate = Color(0.49, 1.0, 1.0)
	

func save_volume(mute, music_vol, sfx_vol):
	var config = ConfigFile.new()
	config.set_value("audio", "music_volume", music_vol)
	config.set_value("audio", "sfx_volume", sfx_vol)
	config.set_value("audio", "mute_volume", mute)
	config.save("user://settings.cfg")

func load_volume():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		# music volume
		var music_vol = config.get_value("audio", "music_volume", 0)
		$Control/settings/HBoxContainer/music.value = music_vol
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_vol)
		# sfx volume
		var sfx_vol = config.get_value("audio", "sfx_volume", 0)
		$Control/settings/HBoxContainer2/sfx.value = sfx_vol
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_vol)
		# mute
		var mute_vol = config.get_value("audio", "mute_volume", false)
		$Control/settings/mute.button_pressed = mute_vol
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), mute_vol)
		
func _on_start_pressed() -> void:
	var level = start.resource_path
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	$Control/menu.visible = false
	$Control/settings.visible = true

func _on_master_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)
	
func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	
func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	
func _on_back_pressed() -> void:
	var music_vol = $Control/settings/HBoxContainer/music.value
	var sfx_vol = $Control/settings/HBoxContainer2/sfx.value
	var mute = $Control/settings/mute.toggle_mode
	save_volume(mute, music_vol, sfx_vol)
	$Control/menu.visible = true
	$Control/settings.visible = false

func _on_difficulty_pressed() -> void:
	$Control/difficulty.visible = true
	$Control/menu.visible = false


func _on_back_difficulty_pressed() -> void:
	$Control/difficulty.visible = false
	$Control/menu.visible = true


func _on_easy_pressed() -> void:
	Global.difficulty = "easy"
	Global.max_health = 5


func _on_normal_pressed() -> void:
	Global.difficulty = "normal"
	Global.max_health = 3


func _on_hard_pressed() -> void:
	Global.difficulty = "hard"
	Global.max_health = 1
