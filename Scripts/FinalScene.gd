extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/AudioManager"._playFinalSceneMusic()
	$AnimationPlayer.play("Destruicao")

func _input(event):
	if event.is_pressed():
		$"/root/AudioManager".get_child(0).queue_free()
		get_tree().change_scene("res://Cenas/Menu.tscn")
