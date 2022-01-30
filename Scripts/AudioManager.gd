extends Node2D


var song
var audioPlayers = {}
var volumeMusicas = -7
var volumeEfeitos = -7
var musicPlayer = null

func _playMenuMusic():
	var p = AudioStreamPlayer.new()
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-2).add_child(p)
	song = load("res://Musics/Mr Snarky Destructoid Loop.wav")
	p.set_stream(song)
	p.volume_db = volumeMusicas
	p.play(0) 

func _playMusic():
	var p = AudioStreamPlayer.new()
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).add_child(p)
	song = load("res://Musics/8Bit DNA Loop.wav")
	p.set_stream(song)
	p.volume_db = volumeMusicas
	p.play(0)
	musicPlayer = p

func _playFinalSceneMusic():
	var p = AudioStreamPlayer.new()
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-2).add_child(p)
	song = load("res://Musics/Chiptune Dream Loop.wav")
	p.set_stream(song)
	p.volume_db = volumeMusicas
	p.play(0) 

func _refreshMusicVolume():
	musicPlayer.volume_db = volumeMusicas

func _pauseSongs(boolean):
	for player in audioPlayers:
		player.stream_paused = boolean

func _playerShot():
	var p = AudioStreamPlayer.new()
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).add_child(p)
	song = load("res://Audios/Laser.ogg")
	p.set_stream(song)
	p.volume_db = volumeEfeitos
	p.play(0)
	p.connect("finished", self, "_queueFreeAudioPlayer", [p])
	

func _playerDamage():
	var p = AudioStreamPlayer.new()
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).add_child(p)
	song = load("res://Audios/DamagePlayer.ogg")
	p.set_stream(song)
	p.volume_db = volumeEfeitos
	p.play(0)
	p.connect("finished", self, "_queueFreeAudioPlayer", [p])
	
func _enemyDamage():
	var p = AudioStreamPlayer.new()
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).add_child(p)
	song = load("res://Audios/DamageEnemy.ogg")
	p.set_stream(song)
	p.volume_db = volumeEfeitos
	p.play(0)
	p.connect("finished", self, "_queueFreeAudioPlayer", [p])

func _playEffectBack():
	var p = AudioStreamPlayer.new()
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).add_child(p)
	song = load("res://Audios/Menu Back.ogg")
	p.set_stream(song)
	p.volume_db = volumeEfeitos
	p.play(0)
	p.connect("finished", self, "_queueFreeAudioPlayer", [p])
	
func _playEffectSelect():
	var p = AudioStreamPlayer.new()
	get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1).add_child(p)
	song = load("res://Audios/Menu Select.ogg")
	p.set_stream(song)
	p.volume_db = volumeEfeitos
	p.play(0)
	p.connect("finished", self, "_queueFreeAudioPlayer", [p])

func _queueFreeAudioPlayer(p):
	audioPlayers.erase(p)
	p.queue_free()
