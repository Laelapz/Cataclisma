extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/AudioManager"._playMenuMusic()
	$Menu/Tween.interpolate_property($Menu/Path2D/PathFollow2D, "unit_offset", 0, 1, 50, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Menu/Tween.start()


func _on_Jogar_pressed():
	$"/root/AudioManager".get_child(0).queue_free()
	get_tree().change_scene("res://Cenas/Mundo.tscn")


func _on_Sair_pressed():
	get_tree().quit()
