extends "res://PlayerInteractionArea.gd"

signal change_image

func player_entered():
	emit_signal("change_image")


func _on_body_entered(body):
	._on_body_entered(body)
