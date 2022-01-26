extends KinematicBody2D

var x = 1
var y = 1
var life = 5
var speed = 40
var player = null
var can_shot = true
var velocity = Vector2()
var minimap_icon = "enemy"

signal removed

const BULLET = preload("res://Cenas/SimpleShotEnemy.tscn")

func _ready():
	$RunerTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return
	if velocity.x < 0:
		$CollisionShape2D/AnimatedSprite.flip_h = true
	else:
		$CollisionShape2D/AnimatedSprite.flip_h = false
		
	if player != null:
		
		if sqrt((pow((global_position.x - player.global_position.x), 2) + pow((global_position.y - player.global_position.y), 2))) <= 100 && can_shot:
			var bullet = BULLET.instance()
			get_parent().add_child(bullet)
			bullet.rotation_degrees = rotation_degrees
			bullet.global_position = global_position
			bullet.apply_impulse(Vector2(), Vector2(bullet.bullet_speed, 0).rotated(get_angle_to(player.global_position)))
			can_shot = false
			$ShotTimer.start()
		else:
			velocity = (player.global_position - global_position).normalized() * speed
			velocity = move_and_slide(velocity)
	else:
		velocity = Vector2(x, y).normalized() * speed
		velocity = move_and_slide(velocity)

func damage():
	get_parent().find_node("ScreenShake").screen_shake(1, 3, 1)
	life -= 1
	
	if life <= 0:
		dead()

func dead():
	emit_signal ("removed", self)
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


func _on_RunerTimer_timeout():
	randomize()
	x = round(rand_range(-1, 1))
	y = round(rand_range(-1, 1))
	$RunerTimer.start()
