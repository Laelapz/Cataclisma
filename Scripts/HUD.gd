extends CanvasLayer

var subiu = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$LifeBar.value = get_parent().find_node("Player").life
	

func lvlUpShow():
	$Tween.interpolate_property($LvlUpSign, "rect_position:x", -150, 50, 3,Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Timer_timeout():
	$Tween.interpolate_property($LvlUpSign, "rect_position:x", 50, -150, 3,Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$Tween.start()

func _showBossBar(maxvalue):
	$BossBar.max_value = maxvalue
	$BossBar.show()

func _actualBossLife(actual_life):
	$BossBar.value = actual_life

func _hideBossBar():
	$BossBar.hide()


func _on_Tween_tween_completed(object, key):
	if !subiu:
		subiu = true
		$Timer.start()
	else:
		subiu = false
