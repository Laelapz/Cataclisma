extends CanvasLayer

func _ready() -> void:
	$ColorRect/CenterContainer/VBoxContainer/Resumir.grab_focus()
#	$PopupMenu/CenterContainer/VBoxContainer/Label/HBoxContainer/Musica.value = get_parent().get_parent().temp_save.music
#	$PopupMenu/CenterContainer/VBoxContainer/Label2/HBoxContainer/Effects.value = get_parent().get_parent().temp_save.effects

func _physics_process(delta) -> void:
	if $ColorRect/CenterContainer/VBoxContainer/Resumir.is_hovered() == true:
		$ColorRect/CenterContainer/VBoxContainer/Resumir.grab_focus()
#
	if $ColorRect/CenterContainer/VBoxContainer/Configuracoes.is_hovered() == true:
		$ColorRect/CenterContainer/VBoxContainer/Configuracoes.grab_focus()
#
	if $ColorRect/CenterContainer/VBoxContainer/Sair.is_hovered() == true:
		$ColorRect/CenterContainer/VBoxContainer/Sair.grab_focus()

func _input(event) -> void:
	if event.is_action_pressed("Pause") && !get_parent().get_parent().find_node("Player").is_dead:
		$ColorRect/CenterContainer/VBoxContainer/Resumir.grab_focus()
		get_tree().paused = not get_tree().paused
		$"/root/AudioManager"._pauseSongs(get_tree().paused)
		$ColorRect.visible = not $ColorRect.visible

func _on_Resumir_pressed() -> void:
	$"/root/AudioManager"._playEffectSelect()
	get_tree().paused = not get_tree().paused
	$ColorRect.visible = not $ColorRect.visible
	$"/root/AudioManager"._pauseSongs(get_tree().paused)
#
func _on_Configuracoes_pressed() -> void:
	$RainbowShader.show()
	$"/root/AudioManager"._playEffectSelect()
	$ColorRect/CenterContainer/Popup.popup()
	$ColorRect/CenterContainer/Popup/Panel/Container/VBoxContainer/VBoxMusic/Music/LessMusic.grab_focus()
#
func _on_Sair_pressed()->void:
	$"/root/AudioManager"._playEffectBack()
	get_tree().change_scene("res://Cenas/Menu.tscn")


func _on_SairPopup_pressed() -> void:
	$RainbowShader.hide()
	$"/root/AudioManager"._playEffectBack()
	$ColorRect/CenterContainer/Popup.hide()
	$ColorRect/CenterContainer/VBoxContainer/Configuracoes.grab_focus()
#
func _on_FullScreen_pressed() -> void:
	$"/root/AudioManager"._playEffectSelect()
	OS.window_fullscreen = !OS.window_fullscreen 

func _on_LessMusic_pressed() -> void:
	$"/root/AudioManager"._playEffectSelect()
	$ColorRect/CenterContainer/Popup/Panel/Container/VBoxContainer/VBoxMusic/Music/MusicBar.value -= 1
	$"/root/AudioManager".volumeMusicas = $ColorRect/CenterContainer/Popup/Panel/Container/VBoxContainer/VBoxMusic/Music/MusicBar.value
	$"/root/AudioManager"._refreshMusicVolume()

func _on_MoreMusic_pressed() -> void:
	$"/root/AudioManager"._playEffectSelect()
	$ColorRect/CenterContainer/Popup/Panel/Container/VBoxContainer/VBoxMusic/Music/MusicBar.value += 1
	$"/root/AudioManager".volumeMusicas = $ColorRect/CenterContainer/Popup/Panel/Container/VBoxContainer/VBoxMusic/Music/MusicBar.value
	$"/root/AudioManager"._refreshMusicVolume()

func _on_LessEffects_pressed() -> void:
	$"/root/AudioManager"._playEffectSelect()
	$ColorRect/CenterContainer/Popup/Panel/Container/VBoxContainer/VBoxEffects/Effects/EffectsBar.value -= 1
	$"/root/AudioManager".volumeEfeitos = $ColorRect/CenterContainer/Popup/Panel/Container/VBoxContainer/VBoxEffects/Effects/EffectsBar.value

func _on_MoreEffects_pressed() -> void:
	$"/root/AudioManager"._playEffectSelect()
	$ColorRect/CenterContainer/Popup/Panel/Container/VBoxContainer/VBoxEffects/Effects/EffectsBar.value += 1
	$"/root/AudioManager".volumeEfeitos = $ColorRect/CenterContainer/Popup/Panel/Container/VBoxContainer/VBoxEffects/Effects/EffectsBar.value
