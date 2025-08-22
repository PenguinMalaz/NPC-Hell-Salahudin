extends Area2D

var direction = Vector2.ZERO
@export var anim : AnimatedSprite2D
var velocity


func _physics_process(delta: float) -> void:
	position += velocity * delta
	
	if position.x < -20 || position.x > 500:
		queue_free()
		
	if velocity.x != 0 && velocity.y == 0:
		anim.play("right")
			
	if velocity.x == 0 && velocity.y != 0:
		if velocity.y > 0:
			anim.play("down")
		if velocity.y < 0:
			anim.play("up")
	
	if velocity.x != 0 && velocity.y != 0:
		if velocity.y > 0:
			anim.play("rightdown")
		else:
			anim.play("rightup")
			
	if velocity.x > 0:
		anim.flip_h = false
	else:
		anim.flip_h = true

func start_moving():
	var speed: int
	
	if Global.difficulty == "normal":
		speed = [100, 200, 300].pick_random()
	elif Global.difficulty == "hard":
		speed = [300, 400, 500].pick_random()
	else:
		speed = [50, 150, 200].pick_random()
	
	
	
	var y = randf_range(-0.5, 0.5)
	if position.x == -20:
		direction = Vector2(1, y).normalized()
	else:
		direction = Vector2(-1, y).normalized()
	velocity = direction * speed
