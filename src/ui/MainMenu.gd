extends Panel

var globals
# Called when the node enters the scene tree for the first time.
func _ready():
	globals = get_node("/root/globals")
	$"MarginContainer/HBoxContainer/VBoxContainer/MenuOptions/New Game".grab_focus()
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_End_pressed():
	get_tree().quit()


func _on_New_Game_pressed():
	globals.goto_next_floor()
