extends CanvasLayer

func _ready():
	$MarginContainer/CenterContainer/VBoxContainer/Button.grab_focus()

func _on_Button_pressed():
	globals.goto_main_menu()
