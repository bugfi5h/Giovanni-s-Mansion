extends CanvasLayer

signal dialogue_animation_finished()

var dialogue_is_playing = false
var greenProgressTexture
var yellowProgressTexture
var redProgressTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	greenProgressTexture = load("res://assets/images/progressbar_green.png")
	yellowProgressTexture = load("res://assets/images/progressbar_yellow.png")
	redProgressTexture = load("res://assets/images/progressbar_red.png")

func update_oil(amount):
	$VBoxContainer/MarginContainer/HBoxContainer/Oil/OilPercent.text = String(amount) + "%"

func updateStaminaBar(amount):
	$VBoxContainer/StaminaMargin/TextureProgress.set_value(amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_lamp_health_changed(amount):
	update_oil(amount)

func _on_Player_stamina_changed(amount):
	if amount >= 50:
		$VBoxContainer/StaminaMargin/TextureProgress.texture_progress = greenProgressTexture
	elif amount >= 20:
		$VBoxContainer/StaminaMargin/TextureProgress.texture_progress = yellowProgressTexture
	else:
		$VBoxContainer/StaminaMargin/TextureProgress.texture_progress = redProgressTexture
	
	if $VBoxContainer/StaminaMargin/TextureProgress.texture_progress == null:
		$VBoxContainer/StaminaMargin/TextureProgress.texture_progress = load("res://assets/images/progressbar_green.png")
		
	updateStaminaBar(amount)
	
	
func set_text(message):
	if !dialogue_is_playing:
		$TextMargin/Text.text = message
		$DialogueAnimationPlayer.play("NewText")
		dialogue_is_playing = true
	

func _set_text(message):
	pass # Replace with function body.

func on_dialogue_animation_finished(name):
	dialogue_is_playing = false
	emit_signal("dialogue_animation_finished")