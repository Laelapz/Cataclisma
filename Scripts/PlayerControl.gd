extends KinematicBody2D

var vel = 100
var life = 500
onready var sprite = $Position2D/Sprite
onready var eye_sprite = $Position2D/EyeSprite
onready var position2D = $Position2D
var mov = Vector2(0,0)
var FPS = 60
var FPS_counter = 0
var can_move = false
var can_damage = true
var is_dead = false
var headColliding = false
var legsColliding = false
var playerDamage = 1
var lvl = 0
var currentXP = 0
var maxXP = pow(2, lvl)

var evolucao = 0

const POLICE = preload("res://Cenas/Police.tscn")
const BLOOD = preload("res://Cenas/BloodParticleCreature.tscn")
	
func update_frame(limit):
	if (FPS_counter > limit):
		sprite.frame = (sprite.frame + 1)%4
		eye_sprite.frame = (eye_sprite.frame + 1)%2
		FPS_counter = 0
	else:
		FPS_counter += 1
	
func _physics_process(delta):
	if currentXP == maxXP:
		updateLvl()
	
	if can_move:
		update_frame(6)
				
		mov  = Vector2()
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
#			$"/root/SpawnManager"._spawnEnemys(5, global_position, 0)
#			$"/root/SpawnManager"._spawnEnemys(5, global_position, 1)
#			$"/root/SpawnManager"._spawnEnemys(5, global_position, 2)
			$"/root/SpawnManager"._spawnNPCs(15, global_position, 0)
#			$"/root/SpawnManager"._spawnBoss(global_position, 0)
#			$"/root/SpawnManager"._spawnBoss(global_position, 1)
#			$"/root/SpawnManager"._spawnBoss(global_position, 2)
#			$"/root/SpawnManager"._spawnNPCs(10, global_position, 0)
#			$"/root/SpawnManager"._spawnBoss(global_position, 0)
#			$"/root/SpawnManager"._spawnBoss(global_position, 1)
#			$"/root/SpawnManager"._spawnBoss(global_position, 2)

		mov = mov.normalized()
		mov = move_and_slide(mov*vel)
		evolve()
	
	if headColliding && !legsColliding:
		z_index = 2
	else:
		z_index = 1

func updateLvl():
	get_parent().find_node("HUD").lvlUpShow()
	lvl += 1
	playerDamage = 1 + 2*lvl
	scale *= 1.05
	life = 500 + 2*lvl
	currentXP = 0
	maxXP = pow(2, lvl)
	print("lvl: ", lvl," damage: ", playerDamage, " life:", life)


func evolve():
	var evo = $"/root/SpawnManager"._get_evolution()
	if evo == 1:
		sprite.texture = load("res://Assets/creature-sheet-evol-1.png")
		scale *= 1.2
		$"/root/SpawnManager".player_evol += 1
		for i in range(1, 7):
			var pos = get_parent().find_node("EnemySpawns").get_child(i).position
			$"/root/SpawnManager"._spawnEnemys(5, pos, 0)
			$"/root/SpawnManager"._spawnEnemys(7, pos, 1)
	elif evo == 3:
		sprite.texture = load("res://Assets/creature-sheet-evol-2.png")
		scale *= 1.2
		$"/root/SpawnManager".player_evol += 1
		for i in range(1, 7):
			var pos = get_parent().find_node("EnemySpawns").get_child(i).position
			$"/root/SpawnManager"._spawnEnemys(1, pos, 0)
			$"/root/SpawnManager"._spawnEnemys(3, pos, 1)
			$"/root/SpawnManager"._spawnEnemys(6, pos, 1)
	elif evo == 5:
		can_move = false
		can_damage = false
		get_parent().find_node("Talk_With_Doctor").startConversation("Entrevista2")
		
func damage(damage):
	if can_damage:
		$"/root/AudioManager"._playerDamage()
		get_parent().find_node("ScreenShake").screen_shake(1, 5, 1)
		var blood = BLOOD.instance()
		add_child(blood)
		blood.emitting = true
		blood.global_position = global_position
		life -= damage
		
		if life <= 0:
			dead()

func dead():
	$"/root/AudioManager"._playerDeath()
	$HeadCollision.set_deferred("disabled", true)
	$LegsCollision.set_deferred("disabled", true)
	sprite.texture = load("res://Assets/creature-sheet-dead.png")
	can_move = false
	is_dead = true


func _on_Head_body_entered(body):
	headColliding = true


func _on_Legs_body_entered(body):
	legsColliding = true


func _on_Head_body_exited(body):
	headColliding = false


func _on_Legs_body_exited(body):
	legsColliding = false
