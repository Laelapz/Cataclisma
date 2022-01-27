extends Node

const ENEMY = preload("res://Cenas/Police.tscn")
var levels = [["police1", "police2", "police3", "sheriff1"], ["mercenary1", "soldier1", "soldier2"], ["robot1", "fbi1"]]


func _spawnNpcs():
	pass

func _spawnEnemys(quantity, position, dificulty):
	randomize()
	for i in quantity:
		var index = round(rand_range(0, levels[dificulty].size()-1))
		var enemy = ENEMY.instance()
		enemy.type = levels[dificulty][index]
		get_tree().get_root().get_child(2).add_child(enemy)
		enemy.global_position.x = round(rand_range(position.x-100, position.x+100))
		enemy.global_position.y = round(rand_range(position.y-100, position.y+100))
		

func _spawnBoss():
	pass
