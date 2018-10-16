extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_oil(amount):
	$MarginContainer/HBoxContainer/Oil/OilPercent.text = String(amount) + "%"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_lamp_health_changed(amount):
	update_oil(amount)
