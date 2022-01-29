extends RayCast2D

var oppened = false
var closing = false

#func _ready():
#	_openInkRay()

func _openInkRay():
	$Tween.interpolate_property(self, "cast_to:y", self.get("cast_to").y, 1000, 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Line2D, "width", 0, 5, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	enabled = true
	oppened = true
	closing = false

func _closeInkRay():
	$Tween.interpolate_property(self, "cast_to:y", self.get("cast_to").y, 0, 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Line2D, "width", 20, 0, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	oppened = false
	closing = true

func _process(delta):
	if oppened:
		force_raycast_update()
		if is_colliding():
			var hit_point = get_collision_point()
			var maxpoint = sqrt(pow((hit_point.x-global_position.x), 2) + pow((hit_point.y-global_position.y), 2))
			$Line2D/Particles2D.global_position = hit_point
			$Line2D/Particles2D.emitting = true
			$Line2D.set_point_position(1, Vector2(0, abs((maxpoint))))
			if get_collider().get_instance_id() == get_parent().get_parent().find_node("Player").get_instance_id():
				get_collider().damage(1)

		else:
			$Line2D/Particles2D.emitting = false
			$Tween.interpolate_property(self, "cast_to:y", get("cast_to").y, 1000, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Line2D.set_point_position(1, Vector2(0, get("cast_to").y))

func _on_Tween_tween_all_completed():
	if closing:
		closing = false
		enabled = false
