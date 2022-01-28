extends Node

const ENEMY = preload("res://Cenas/Police.tscn")
const NPC   = preload("res://Cenas/NPC.tscn")

const BOSS_RELAMPAGO    = preload("res://Cenas/BossRelampago.tscn")
const BOSS_HOMEM_SUPER  = preload("res://Cenas/BossHomemSuper.tscn")
const BOSS_MAGA_SUPREMA = preload("res://Cenas/BossMagaSuprema.tscn")

var levels = [["police1", "police2", "police3", "sheriff1"], ["mercenary1", "soldier1", "soldier2"], ["robot1", "fbi1"]]
var npc_type = [["Menino", "Dona", "Professora", "Paramedico"], ["Egirl", "Punk", "Adolescente", "Artista"], ["Empresario", "Pedreiro", "Atriz"]]
var boss_type = ["BossRelampago", "BossHomemSuper", "BossMagaSuprema"]

func _spawnBoss(position, dificulty):
	var boss = null
	if dificulty == 0:
		boss = BOSS_RELAMPAGO.instance()
	elif dificulty == 1:
		boss = BOSS_HOMEM_SUPER.instance()
	elif dificulty == 2:
		boss = BOSS_MAGA_SUPREMA.instance()
	get_tree().get_root().get_child(2).add_child(boss)
	boss.global_position.x = round(rand_range(position.x-100, position.x+100))
	boss.global_position.y = round(rand_range(position.y-100, position.y+100))

func _spawnNPCs(quantity, position, dificulty):
	randomize()
	for i in quantity:
		var index = round(rand_range(0, npc_type[dificulty].size()-1))
		var npc = NPC.instance()
		npc.type = npc_type[dificulty][index]
		get_tree().get_root().get_child(2).add_child(npc)
		npc.global_position.x = round(rand_range(position.x-100, position.x+100))
		npc.global_position.y = round(rand_range(position.y-100, position.y+100))
		

func _spawnEnemys(quantity, position, dificulty):
	randomize()
	for i in quantity:
		var index = round(rand_range(0, levels[dificulty].size()-1))
		var enemy = ENEMY.instance()
		enemy.type = levels[dificulty][index]
		get_tree().get_root().get_child(2).add_child(enemy)
		enemy.global_position.x = round(rand_range(position.x-100, position.x+100))
		enemy.global_position.y = round(rand_range(position.y-100, position.y+100))
		
