extends Node2D

@onready var _bgm : AudioStreamPlayer = $Bgm
@onready var _gameover : AudioStreamPlayer = $Gameover
@onready var _hurt : AudioStreamPlayer = $Hurt
@onready var _pickup : AudioStreamPlayer = $Pickup

func bgm():
	if _gameover.playing:
		_gameover.stop()
	if _bgm.playing:
		_bgm.stop()
	else:
		_bgm.play()

func gameover():
	if _bgm.playing:
		_bgm.stop()
	if _gameover.playing:
		_gameover.stop()
	else:
		_gameover.play()

func hurt():
	_hurt.play()

func pickup():
	_pickup.play()
