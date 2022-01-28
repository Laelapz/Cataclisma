extends MarginContainer


export (NodePath) var player
export var zoom = 0.5 setget set_zoom

onready var grid = $MarginContainer/Grid

onready var player_marker = $MarginContainer/Grid/PlayerMarker
onready var enemy_marker = $MarginContainer/Grid/EnemyMarker
onready var hero_marker = $MarginContainer/Grid/HeroMarker
onready var npc_marker = $MarginContainer/Grid/NpcMarker

onready var icons = {'enemy': enemy_marker, 'hero': hero_marker, 'npc': npc_marker}

var grid_scale
var markers = {}

func _ready():
	player_marker.position = grid.rect_size / 2
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		var new_marker = icons[item.minimap_icon].duplicate()
		grid.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker
		item.connect ("removed", self, "_on_object_removed")


func _process(delta):
	if !player:
		return
	player_marker.rotation = get_node(player).rotation + PI / 2
	
	for item in markers:
		var radius = grid.rect_size.x/2
		var obj_pos = (item.position - get_node(player).position) * grid_scale + grid.rect_size / 2
		
		var pos = obj_pos - Vector2(radius, radius)
		var lim =  sqrt(pos.x*pos.x + pos.y*pos.y) 
		pos = pos.normalized()
		
		pos.x = ( pos.x * (sqrt(1 - (pos.y*pos.y)/2 )) )
		pos.y = ( pos.y * (sqrt(1 - (pos.x*pos.x)/2 )) )
		
		pos *= Vector2(radius, radius)
		pos += Vector2(radius, radius)
		
		if( lim > radius ):
			obj_pos = pos

#		obj_pos = pos

		#obj_pos.x = clamp(obj_pos.x, 0, radius)
#		obj_pos.y = clamp(obj_pos.y, 0, sqrt(pow(radius, 2) - pow(obj_pos.x, 2)))
#		obj_pos.x = radius
			
		markers[item].position = obj_pos

func _new_marker (item):
	var new_marker = icons [item.minimap_icon] .duplicate ()
	grid.add_child (new_marker)
	new_marker.show ()
	markers [item] = new_marker
	item.connect ("removed", self, "_on_object_removed")

func _on_object_removed(item):
	markers[item].hide()
	markers.erase(item)

func set_zoom(value):
	zoom = clamp(value, 0.2, 5)
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)

func set_more_zoom():
	self.zoom += 0.1

func set_less_zoom():
	self.zoom -= 0.1

