extends Node2D

var lvl1_player : AudioStreamPlayer
var lvl2_player : AudioStreamPlayer
var lvl3_player : AudioStreamPlayer

var player
var wrath

# Called when the node enters the scene tree for the first time.
func _ready():
	lvl1_player = $DangerLevel_1_Player
	lvl2_player = $DangerLevel_2_Player
	lvl3_player = $DangerLevel_3_Player
	
	lvl1_player.set_volume_db(0)
	lvl2_player.set_volume_db(-100)
	lvl3_player.set_volume_db(-100)
	
	lvl1_player.play()
	lvl2_player.play()
	lvl3_player.play()
	
	player = get_tree().get_root().find_node("Player")
	wrath = get_tree().get_root().find_node("Wrath")
	pass # Replace with function body.

func updateVolume():
	var distance = getDistance(player, wrath)
	lvl2_player.set_volume_db(-distance)
	lvl3_player.set_volume_db(-distance-10)
	

func getDistance(node1, node2):
	return (node1.position - node2.position).length()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
