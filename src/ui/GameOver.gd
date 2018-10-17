extends CanvasLayer

func _ready():
	$MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/Stage.text = globals.get_display_stage_level()

func _on_Button_pressed():
	globals.goto_main_menu()
