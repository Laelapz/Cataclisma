extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	$"/root/AudioManager"._playMenuMusic()
	$Menu/Tween.interpolate_property($Menu/MarginContainer/Player, "rotation_degrees", -180, 180, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Menu/Tween.interpolate_property($Menu/MarginContainer/Police, "rotation_degrees", 180, -180, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Menu/Tween.interpolate_property($Menu/MarginContainer/FBI, "rotation_degrees", -180, 180, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Menu/Tween.interpolate_property($Menu/MarginContainer/Reporter, "rotation_degrees", 180, -180, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Menu/Tween.start()

func _on_Jogar_pressed():
	$"/root/AudioManager".get_child(0).queue_free()
	get_tree().change_scene("res://Cenas/Mundo.tscn")


func _on_Sair_pressed():
	get_tree().quit()
