extends Node2D

var cursor = load("res://Assets/mouse_sprite.png")

func _ready():
	$"/root/AudioManager"._playMusic()
	$Player.can_move = false
	$Talk_With_Doctor.startConversation("Entrevista1")
#	var dialog = Dialogic.start("Dialogo1")
#	add_child(dialog)
#	dialog.connect("dialogic_signal", self, "_dialog_finished")
	Input.set_custom_mouse_cursor(cursor)

	
	#Spawn Bosses
	$"/root/SpawnManager"._spawnBoss($RelampagoArea.position, 0)
	$"/root/SpawnManager"._spawnBoss($HomemSuperArea.position, 1)
	$"/root/SpawnManager"._spawnBoss($MagaSupremaArea.position, 2)
	
	#Spawn NPCs
	
	#Spawn Enemies

func _input(event):
	if(event.is_pressed() && find_node("Player").is_dead):
		get_tree().change_scene("res://Cenas/Menu.tscn")
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_WHEEL_UP:
			$HUD/MiniMap.set_less_zoom()
		if event.button_index == BUTTON_WHEEL_DOWN:
			$HUD/MiniMap.set_more_zoom()

func _dialog_finished():
	var player = find_node("Player")
	player.can_damage = true
	player.can_move = true
