extends Area2D

var player_class = preload("res://characters/player/Player.gd")

func _on_body_entered(body):
	if body is player_class:
		player_entered()
		queue_free()
		
func player_entered():
	pass