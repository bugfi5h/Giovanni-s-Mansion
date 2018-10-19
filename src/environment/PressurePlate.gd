extends Node2D

signal pressure_plate_pushed(is_pushed_in)

export(Texture) var unpushed_state
export(Texture) var pushed_state
export(bool) var only_activation = false
export(bool) var pushed = false
var player_class = preload("res://characters/player/Player.gd")

var first_state


# Called when the node enters the scene tree for the first time.
func _ready():
	first_state = pushed
	if pushed:
		$Sprite.texture = pushed_state
	else:
		$Sprite.texture = unpushed_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if(body is player_class):
		if only_activation:
			if first_state != pushed:
				return
		if pushed:
			$Sprite.texture = unpushed_state
			pushed = false
		else:
			$Sprite.texture = pushed_state
			pushed = true
		emit_signal("pressure_plate_pushed", pushed)

func _on_pressure_plate_pushed(pushed):
	if pushed:
		$Sprite.texture = unpushed_state
		pushed = false
	else:
		$Sprite.texture = pushed_state
		pushed = true