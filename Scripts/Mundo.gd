extends Node2D

var cursor = load("res://Assets/mouse_sprite.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass