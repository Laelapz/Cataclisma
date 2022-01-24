extends KinematicBody2D

var vel = 150
onready var sprite = $Position2D/Sprite	
onready var eye_sprite = $Position2D/EyeSprite	
onready var position2D = $Position2D
var FPS = 60
var FPS_counter = 0

func _ready():
	pass 
	
func update_frame(limit):
	if (FPS_counter > limit):
		sprite.frame = (sprite.frame + 1)%4
		eye_sprite.frame = (eye_sprite.frame + 1)%2
		FPS_counter = 0
	else:
		FPS_counter += 1
	
func _physics_process(delta):
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

	mov = mov.normalized()
	mov = move_and_slide(mov*vel);
	
