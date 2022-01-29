extends CanvasLayer


var fade_out = false

func startConversation(Talk):
	fade_out = false
	$ColorRect.modulate.a = 1
	$ColorRect.show()
	$Background.show()
	var dialog = Dialogic.start(Talk)
	get_parent().find_node("Player").can_move = false
	get_parent().find_node("Player").can_damage = false
	add_child(dialog)
	dialog.connect("dialogic_signal", self, "_dialog_finished")

func fadeIn():
	$Tween.interpolate_property($ColorRect, "modulate:a", $ColorRect.modulate.a, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
func fadeOut():
	$Tween.interpolate_property($ColorRect, "modulate:a", $ColorRect.modulate.a, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Background, "modulate:a", $Background.modulate.a, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func falaDoc():
	$Background/Doc.play("fala")
	$Background/FalaTimer.start(1)

func showDoc():
	$Background/Doc.show()

func falaReporter():
	$Background/Reporter.play("fala")
	$Background/FalaTimer.start(1)

func _on_FalaTimer_timeout():
	$Background/Doc.stop()
	$Background/Reporter.stop()
	$Background/Doc.frame = 0
	$Background/Reporter.frame = 0
	
func _dialog_finished(param):
	if param == "fade_in":
		fadeIn()
	elif param == "talk_doc":
		falaDoc()
	elif param == "show_doc":
		showDoc()
	elif param == "talk_rep":
		falaReporter()
	elif param == "fade_out":
		fade_out = true
		fadeOut()


func _on_Tween_tween_completed(object, key):
	if fade_out:
		get_parent().find_node("Player").can_move = true
		get_parent().find_node("Player").can_damage = true
		$Background.hide()
		$ColorRect.hide()
