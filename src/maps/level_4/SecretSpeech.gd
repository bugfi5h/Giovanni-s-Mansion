extends "res://environment/PlayerInteractionArea.gd"

signal send_text_to_player(message)

export(String) var message = ""

func player_entered():
	emit_signal("send_text_to_player", message)

func _on_body_entered(body):
	._on_body_entered(body)
