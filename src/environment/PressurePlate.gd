extends Node2D

signal body_entered

export(Texture) var unpushed_state
export(Texture) var pushed_state
export(bool) var pushed = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if pushed:
		$Sprite.texture = pushed_state
	else:
		$Sprite.texture = unpushed_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if pushed:
		$Sprite.texture = unpushed_state
		pushed = false
	else:
		$Sprite.texture = pushed_state
		pushed = true
	emit_signal("body_entered", body, pushed)
