extends MarginContainer


var cursor = load("res://Assets/mouse_sprite.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(cursor)
	get_tree().paused = false
	$"/root/AudioManager"._playMenuMusic()
	$Menu/MarginContainer/VBoxContainer/HBoxContainer/Jogar.grab_focus()
	$Menu/Tween.interpolate_property($Menu/Path2D/PathFollow2D, "unit_offset", 0, 1, 50, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Menu/Tween.start()
	
	
func _process(delta):
	if $Menu/MarginContainer/VBoxContainer/HBoxContainer/Jogar.is_hovered():
		$Menu/MarginContainer/VBoxContainer/HBoxContainer/Jogar.grab_focus()
	if $Menu/MarginContainer/VBoxContainer/HBoxContainer/Sair.is_hovered():
		$Menu/MarginContainer/VBoxContainer/HBoxContainer/Sair.grab_focus()
	
func _on_Jogar_pressed():
	$"/root/AudioManager".get_child(0).queue_free()
	get_tree().change_scene("res://Cenas/Mundo.tscn")


func _on_Sair_pressed():
	get_tree().quit()
