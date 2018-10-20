extends Node2D

const GameOver = preload("res://ui/GameOver.gd")

var lvl1_player : AudioStreamPlayer
var lvl2_player : AudioStreamPlayer
var lvl3_player : AudioStreamPlayer

var playerPosition : Vector2
var wrathPosition : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	lvl1_player = $DangerLevel_1_Player
	lvl2_player = $DangerLevel_2_Player
	lvl3_player = $DangerLevel_3_Player
	
	lvl1_player.set_volume_db(0)
	lvl2_player.set_volume_db(-100)
	lvl3_player.set_volume_db(-100)
	
	_stop_playback()
	
	var globals = get_node("/root/globals")
	globals.connect("scene_changed", self, "_on_scene_changed")
	_on_scene_changed(globals.current_scene)

func _on_scene_changed(new_scene):
	playerPosition = Vector2.ZERO
	wrathPosition = Vector2.ZERO
	connect_player_and_wrath(new_scene)
	

func _stop_playback():
	print("playback stopped")
	lvl1_player.stop()
	lvl2_player.stop()
	lvl3_player.stop()

func _start_playback():
	print("playback started")
	lvl1_player.play()
	lvl2_player.play()
	lvl3_player.play()

func connect_player_and_wrath(scene):
	var player = scene.find_node("Player")
	if player != null:
		player.connect("player_moved", self, "_on_Player_player_moved")
		if $Menu_Player.playing:
			$Menu_Player.stop()
		if  !lvl1_player.playing:
			_start_playback()
	else:
		_stop_playback()
		if !scene is GameOver:
			_play_menu_music()
		
	var wrath = scene.find_node("Wrath")
	if wrath != null:
		wrath.connect("wrath_moved", self, "_on_Wrath_wrath_moved")

func _play_menu_music():
	if !$Menu_Player.playing:
		$Menu_Player.play()

func _process(delta):
	updateVolume()

func updateVolume():
	var distance
	if playerPosition != Vector2.ZERO && wrathPosition != Vector2.ZERO:
		distance = playerPosition.distance_to(wrathPosition)
	else:
		distance = 100000
	
	lvl2_player.set_volume_db(-(distance / 20))
	lvl3_player.set_volume_db(-(distance / 10))
	

	if distance < 8:
		AudioServer.set_bus_effect_enabled(0, 0, true)
	else:
		AudioServer.set_bus_effect_enabled(0, 0, false)

func getDistance(pos1, pos2):
	return (pos1 - pos2).length()
	
func _on_Player_player_moved(newPosition):
	playerPosition = newPosition
	
func _on_Wrath_wrath_moved(newPosition):
	wrathPosition = newPosition
