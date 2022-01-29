extends KinematicBody2D

var x = 1
var y = 1
var life = 5
var speed = 500
var damage = 0
export var type = ""
var player = null
var can_shot = true
var velocity = Vector2()
var minimap_icon = "hero"
var rng = RandomNumberGenerator.new()

signal removed

const BULLET = preload("res://Cenas/RelampagoShot.tscn")

func _ready():
	get_parent().find_node("MiniMap")._new_marker(self)
	$CollisionShape2D/AnimatedSprite.play(type)
	$RunerTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	return
	if velocity.x < 0:
		$CPUParticles2D.gravity.x = 100
		$CollisionShape2D/AnimatedSprite.flip_h = true
	else:
		$CPUParticles2D.gravity.x = -100
		$CollisionShape2D/AnimatedSprite.flip_h = false
		
	if player != null:
		var dist_from_player = sqrt((pow((global_position.x - player.global_position.x), 2) + pow((global_position.y - player.global_position.y), 2)))
		
		if dist_from_player <= 200:		
			if dist_from_player >= 80:
				rng.randomize()
				var my_random_x = rng.randf_range(-70.0, 70.0)
				var my_random_y = rng.randf_range(-70.0, 70.0)
				var random_vel = Vector2(my_random_x, my_random_y)
				velocity = (player.global_position - global_position + random_vel).normalized()
				print(speed)
				velocity = move_and_slide(velocity*speed)
	
			if dist_from_player <= 150 && can_shot:
				var bullet = BULLET.instance()
				get_parent().add_child(bullet)
				bullet.damage = damage
				bullet.rotation_degrees = rotation_degrees
				bullet.global_position = global_position
				bullet.apply_impulse(Vector2(), Vector2(bullet.bullet_speed, 0).rotated(get_angle_to(player.global_position)))
				can_shot = false
				$ShotTimer.start()
	else:
		velocity = Vector2(x, y).normalized() * speed
		velocity = move_and_slide(velocity)

func damage():
	$"/root/AudioManager"._enemyDamage()
	get_parent().find_node("ScreenShake").screen_shake(1, 3, 1)
	life -= 1
	
	if life <= 0:
		dead()

func dead():
	emit_signal ("removed", self)
	queue_free()

func _on_Area2D_body_entered(body):
	$Atention.show()
	speed = 200
	player = body

func _on_Area2D_body_exited(body):
	$Atention.hide()
	speed = 400
	player = null

func _on_ShotTimer_timeout():
	can_shot = true

func _on_RunerTimer_timeout():
	randomize()
	x = round(rand_range(-1, 1))
	y = round(rand_range(-1, 1))
	$RunerTimer.start()
