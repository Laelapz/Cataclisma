extends Node2D

var cursor = load("res://Assets/mouse_sprite.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_WHEEL_UP:
			$HUD/MiniMap.set_less_zoom()
		if event.button_index == BUTTON_WHEEL_DOWN:
			$HUD/MiniMap.set_more_zoom()
