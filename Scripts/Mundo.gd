extends Node2D

var cursor = load("res://Assets/mouse_sprite.png")

func _ready():
	var dialog = Dialogic.start("Dialogo1")
	add_child(dialog)
	dialog.connect("dialogic_signal", self, "_dialog_finished")
	Input.set_custom_mouse_cursor(cursor)
	$Player/Camera2D.limit_left


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_WHEEL_UP:
			$HUD/MiniMap.set_less_zoom()
		if event.button_index == BUTTON_WHEEL_DOWN:
			$HUD/MiniMap.set_more_zoom()
