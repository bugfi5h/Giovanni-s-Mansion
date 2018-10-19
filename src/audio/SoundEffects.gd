extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _play_game_over():
	$GameOver.play()

func _play_move_wall():
	$MoveWall.play()
	
func _stop_move_wall():
	$MoveWall.stop()
	
func _play_button_click():
	$ButtonClick.play()

#func _play_move_wall():
#	$MoveWall.play()
#
#func _play_move_wall():
#	$MoveWall.play()
