extends KinematicBody2D

var x = 1
var y = 1
export var life = 5
export var speed = 60
export var damage = 1
export var type = ""
var player = null
var can_shot = true
var velocity = Vector2()
var minimap_icon = "hero"
var rng = RandomNumberGenerator.new()

var headColliding = false
var legsColliding = false

signal removed

const BULLET = preload("res://Cenas/HomemSuperShot.tscn")

func _ready():
	get_parent().find_node("MiniMap")._new_marker(self)
	$CollisionShape2D/AnimatedSprite.play(type)
	_setStatus(type)
	$RunerTimer.start()

func _setStatus(type):
	life = 5
	speed = 40
	damage = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	return
	if velocity.x < 0:
		$CollisionShape2D/AnimatedSprite.flip_h = true
	else:
		$CollisionShape2D/AnimatedSprite.flip_h = false
		
	if player != null:
		var num = 0
		var dist_from_player = sqrt((pow((global_position.x - player.global_position.x), 2) + pow((global_position.y - player.global_position.y), 2)))
		
		if dist_from_player <= 250:
			if dist_from_player >= 80:
				rng.randomize()
				var my_random_x = rng.randf_range(-170.0, 170.0)
				var my_random_y = rng.randf_range(-170.0, 170.0)
				var random_vel = Vector2(my_random_x, my_random_y)
				velocity = (player.global_position - global_position + random_vel).normalized() * speed
				velocity = move_and_slide(velocity)
			if dist_from_player <= 150 && can_shot && num == 0:
				num += 1
				shotInRay()
#				shotInFan()
#				var bullet = BULLET.instance()
#				get_parent().add_child(bullet)
#				bullet.damage = damage
#				bullet.rotation_degrees = rotation_degrees
#				bullet.global_position = global_position
#				bullet.apply_impulse(Vector2(), Vector2(bullet.bullet_speed, 0).rotated(get_angle_to(player.global_position)))
#				can_shot = false
#				$ShotTimer.start()
	else:
		velocity = Vector2(x, y).normalized() * speed
		velocity = move_and_slide(velocity)

	if headColliding && !legsColliding:
		z_index = 1
	else:
		z_index = 0

func damage():
	$"/root/AudioManager"._enemyDamage()
	
	get_parent().find_node("ScreenShake").screen_shake(1, 3, 1)
	life -= 1
	
	if life <= 0:
		dead()

func dead():
	emit_signal ("removed", self)
	$"/root/SpawnManager"._evol_player()
	queue_free()

func _on_Area2D_body_entered(body):
	$Atention.show()
	speed = 110
	player = body


func _on_Area2D_body_exited(body):
	$Atention.hide()
	speed = 40
	player = null


func _on_ShotTimer_timeout():
	can_shot = true
	$LaserTimer.stop()
	$RayCast2D._closeInkRay()
	$RayCast2D/Line2D/ParticlesEye.emitting = false


func _on_RunerTimer_timeout():
	randomize()
	x = round(rand_range(-1, 1))
	y = round(rand_range(-1, 1))
	$RunerTimer.start()

func shotInFan():
	for i in [-100, -50, 0, 50, 100]:
		var bullet = BULLET.instance()
		get_parent().add_child(bullet)
		bullet.bullet_speed = 200
		bullet.damage = damage
		bullet.rotation_degrees = rotation_degrees
		bullet.global_position = global_position
		bullet.apply_impulse(Vector2(), Vector2(bullet.bullet_speed, 0).rotated(get_angle_to(player.global_position)+i))
		can_shot = false
		$ShotTimer.start()

func shotInRay():
	print("entrou")
	$RayCast2D/Line2D.width = 5
	$RayCast2D/Line2D/ParticlesEye.emitting = true
	$RayCast2D/Line2D/Particles2D.scale = Vector2(0.01, 0.01)
#	$RayCast2D.transform.rotated(get_angle_to(player.global_position))
	$RayCast2D.rotation = (player.global_position - $RayCast2D.global_position).normalized().angle()
	$RayCast2D.rotation_degrees += 230
	$RayCast2D._openInkRay()
	$LaserTimer.start()
	can_shot = false
	$ShotTimer.start(3)


func _on_Head_body_entered(body):
	headColliding = true


func _on_Legs_body_entered(body):
	legsColliding = true


func _on_Head_body_exited(body):
	headColliding = false


func _on_Legs_body_exited(body):
	legsColliding = false


func _on_LaserTimer_timeout():
	$RayCast2D.rotation_degrees += 3
