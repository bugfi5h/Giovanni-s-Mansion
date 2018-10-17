extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	var globals = get_node("/root/globals")
	$MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/Stage.text = globals.get_display_stage_level()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
