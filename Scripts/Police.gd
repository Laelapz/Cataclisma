extends KinematicBody2D

var life = 5
var speed = 10
var player = null
var can_shot = true

const BULLET = preload("res://Cenas/SimpleShotEnemy.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		
		if global_position.x < player.global_position.x:
			$CollisionShape2D/AnimatedSprite.flip_h = false
		else:
			$CollisionShape2D/AnimatedSprite.flip_h = true
		
		if sqrt((pow((global_position.x - player.global_position.x), 2) + pow((global_position.y - player.global_position.y), 2))) <= 100 && can_shot:
			var bullet = BULLET.instance()
			get_parent().add_child(bullet)
			bullet.rotation_degrees = rotation_degrees
			bullet.global_position = global_position
			bullet.apply_impulse(Vector2(), Vector2(bullet.bullet_speed, 0).rotated(get_angle_to(player.global_position)))
			can_shot = false
			$ShotTimer.start()
		else:
			self.global_position = lerp(global_position, player.global_position, delta)

func damage():
	life -= 1
	
	if life <= 0:
		dead()

func dead():
	queue_free()

func _on_Area2D_body_entered(body):
	print(body)
	player = body


func _on_Area2D_body_exited(body):
	player = null


func _on_ShotTimer_timeout():
	can_shot = true
