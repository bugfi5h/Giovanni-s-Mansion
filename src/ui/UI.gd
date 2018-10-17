extends CanvasLayer

var greenProgressTexture
var yellowProgressTexture
var redProgressTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	greenProgressTexture = load("res://assets/images/progressbar_green.png")
	yellowProgressTexture = load("res://assets/images/progressbar_yellow.png")
	redProgressTexture = load("res://assets/images/progressbar_red.png")

func update_oil(amount):
	$MarginContainer/HBoxContainer/Oil/OilPercent.text = String(amount) + "%"

func updateStaminaBar(amount):
	$MarginContainer2/StaminaContainer/TextureProgress.set_value(amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_lamp_health_changed(amount):
	update_oil(amount)

func _on_Player_stamina_changed(amount):
	if amount >= 50:
		$MarginContainer2/StaminaContainer/TextureProgress.texture_progress = greenProgressTexture
	elif amount >= 20:
		$MarginContainer2/StaminaContainer/TextureProgress.texture_progress = yellowProgressTexture
	else:
		$MarginContainer2/StaminaContainer/TextureProgress.texture_progress = redProgressTexture
	
	if $MarginContainer2/StaminaContainer/TextureProgress.texture_progress == null:
		$MarginContainer2/StaminaContainer/TextureProgress.texture_progress = load("res://assets/images/progressbar_green.png")
		
	updateStaminaBar(amount)