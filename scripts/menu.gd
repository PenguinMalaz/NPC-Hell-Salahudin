extends Node2D

@export var pause_menu : CanvasLayer

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		pause_menu.visible = get_tree().paused
