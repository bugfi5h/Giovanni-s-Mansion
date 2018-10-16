extends Node2D

signal body_entered

export(Texture) var unpushed_state
export(Texture) var pushed_state
export(bool) var only_activation = false
export(bool) var pushed = false
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
	if only_activation:
		if first_state != pushed:
			return
	if pushed:
		$Sprite.texture = unpushed_state
		pushed = false
	else:
		$Sprite.texture = pushed_state
		pushed = true
	emit_signal("body_entered", body, pushed)
