extends Sprite

func _ready():
	pass 

func _process(delta):
	look_at(get_global_mouse_position())
