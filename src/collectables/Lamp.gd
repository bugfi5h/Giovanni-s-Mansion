extends Node2D

export(int) var lamp_oil_amount = 1
var collected = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func collected():
	$Label.text = "+" + String(lamp_oil_amount)
	$lamp.hide()
	$AnimationPlayer.play("Collected")

func _on_Area2D_body_entered(body):
	if !collected:
		collected = true
		var player_class = load("res://characters/player/Player.gd")
		if body is player_class:
			body.add_lamp_health(lamp_oil_amount)
			collected()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Collected":
		queue_free()
