extends RigidBody2D

var bullet_speed = 400

func _ready():
	pass

func _on_RigidBody2D_body_entered(body):
	if "Player" in body.name:
		body.damage()
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
