extends KinematicBody2D

var x = 1
var y = 1
export var life = 5
export var speed = 40
export var damage = 1
export var type = ""
var player = null
var can_shot = true
var velocity = Vector2()
var minimap_icon = "enemy"
var rng = RandomNumberGenerator.new()

signal removed

const BULLET = preload("res://Cenas/SimpleShotEnemy.tscn")

func _ready():
	get_parent().find_node("MiniMap")._new_marker(self)
	$CollisionShape2D/AnimatedSprite.play(type)
	_setStatus(type)
	$RunerTimer.start()

func _setStatus(type):
	life = 5
	speed = 40
	damage = 0
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	return
	if velocity.x < 0:
		$CollisionShape2D/AnimatedSprite.flip_h = true
	else:
		$CollisionShape2D/AnimatedSprite.flip_h = false
	
	rng.randomize()
	var my_random_x = rng.randf_range(-150.0, 100.0)
	var my_random_y = rng.randf_range(-150.0, 100.0)
	var random_vel = Vector2(my_random_x, my_random_y)
	
	if player != null:
		var dist_from_player = sqrt((pow((global_position.x - player.global_position.x), 2) + pow((global_position.y - player.global_position.y), 2)))
		
		if dist_from_player <= 250:		
			velocity = ( player.global_position - global_position ).normalized() * speed
			velocity = -velocity
			velocity = move_and_slide(velocity)
		
	else:
		velocity = (Vector2(x, y)).normalized() * speed
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
