extends "res://maps/Map.gd"

signal set_Player_inputIsEnabled(isEnabled)
signal let_Player_talk(message)

var playerName = "Bob"
var introduction_texts = [ 
	"How the hell did I get here?",
	"I have absolutly no idea what happened last night.",
	"Damn alcohol! I shouldn't have trusted that cat....",
	"Well let's find out what this place is. Looks a bit... shadowy..."
]
var current_text = 0
var player_lamp_decrease_temp

# Called when the node enters the scene tree for the first time.
func _ready():
	if !OS.is_debug_build():
		start_introduction()
	

func start_introduction():
	emit_signal("set_Player_inputIsEnabled", false)
	emit_signal("let_Player_talk", playerName + ": " + introduction_texts[current_text])
	current_text = current_text + 1
	player_lamp_decrease_temp = $Player.lamp_decrease
	$Player.lamp_decrease = 0

func end_introduction():
	emit_signal("set_Player_inputIsEnabled", true)
	$Player.lamp_decrease = player_lamp_decrease_temp	
	
func _on_previous_animation_finished():
	print("jo")
	if current_text < introduction_texts.size() && !OS.is_debug_build():
		emit_signal("let_Player_talk", playerName + ": " + introduction_texts[current_text])
		current_text = current_text + 1
	else:
		end_introduction()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

