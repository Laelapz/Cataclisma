extends KinematicBody2D

var vel = 150
var life = 100
onready var sprite = $Position2D/Sprite
onready var eye_sprite = $Position2D/EyeSprite
onready var position2D = $Position2D
var FPS = 60
var FPS_counter = 0
var can_move = false
var can_damage = true

const POLICE = preload("res://Cenas/Police.tscn")

	
func update_frame(limit):
	if (FPS_counter > limit):
		sprite.frame = (sprite.frame + 1)%4
		eye_sprite.frame = (eye_sprite.frame + 1)%2
		FPS_counter = 0
	else:
		FPS_counter += 1
	
func _physics_process(delta):
	if can_move:
		update_frame(6)
				
		var mov  = Vector2()
		if Input.is_action_pressed("esq"):
			mov.x -= 1
			update_frame(4)
			position2D.scale.x = -1
		if Input.is_action_pressed("dir"):
			mov.x += 1
			update_frame(4)
			position2D.scale.x = 1
		if Input.is_action_pressed("cima"):
			mov.y -= 1
			update_frame(4)
		if Input.is_action_pressed("baixo"):
			mov.y += 1
			update_frame(4)
			
		if Input.is_action_just_pressed("ui_focus_next"):
			$"/root/SpawnManager"._spawnEnemys(10, global_position, 0)
#			$"/root/SpawnManager"._spawnNPCs(10, global_position, 0)

		mov = mov.normalized()
		mov = move_and_slide(mov*vel)

func damage(damage):
	if can_damage:
		$"/root/AudioManager"._playerDamage()
		get_parent().find_node("ScreenShake").screen_shake(1, 5, 1)
		life -= damage
		
		if life <= 0:
			dead()

func dead():
	$HeadCollision.set_deferred("disabled", true)
	$LegsCollision.set_deferred("disabled", true)
	can_move = false
