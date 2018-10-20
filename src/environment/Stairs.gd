extends Node2D

signal player_uses_stairs()

var player_class = preload("res://characters/player/Player.gd")
var globals
# Called when the node enters the scene tree for the first time.
func _ready():
	globals = get_node("/root/globals")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body is player_class:
		globals.goto_next_floor()
		emit_signal("player_uses_stairs")
