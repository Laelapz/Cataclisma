extends RigidBody2D

var bullet_speed = 400
var damage = 1

func _ready():
	pass

func _on_RigidBody2D_body_entered(body):
	if "Enemy" in body.name:
		body.damage(damage)
	if "NPC" in body.name:
		body.damage(damage)
	if "Boss" in body.name:
		body.damage(damage)
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
