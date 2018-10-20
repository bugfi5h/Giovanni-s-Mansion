extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/Button.grab_focus()


func _on_Button_pressed():
	globals.goto_main_menu()
