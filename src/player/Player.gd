extends KinematicBody2D

export(int) var lamp_health = 100
var velocity = Vector2()
const max_speed = 200

var anim = ""

onready var sprite = $Sprite

func _ready():
	$LightAnimation.play("glow")

func _physics_process(delta):
	control(delta)
	move_and_slide(velocity)
	play_animation()

func control(delta):
	velocity = Vector2()
	if Input.is_action_pressed('move_up'):
		velocity = Vector2(0,-max_speed)
	if Input.is_action_pressed('move_down'):
		velocity = Vector2(0,max_speed)
	if Input.is_action_pressed('move_left'):
		velocity = Vector2(-max_speed,0)
	if Input.is_action_pressed('move_right'):
		velocity = Vector2(max_speed,0)
	
	### ANIMATION ###
func play_animation():
	var new_anim = "idle"
	
	if velocity.x < 0:
		new_anim = "Run Left"
	if velocity.x > 0:
		new_anim = "Run Right"
	if velocity.y > 0:
		new_anim = "Run Down"
	if velocity.y < 0:
		new_anim = "Run Up"
		
	if new_anim != anim:
		anim = new_anim
		$AnimationPlayer.play(anim)
	
func _on_LampTimer_timeout():
	lamp_health = lamp_health - 1
	update_lamp()
	
func update_lamp():
	var lamp_light = max(0.3 * (lamp_health / 100.0), 0)
	$Lamp.texture_scale = lamp_light
	if(lamp_light <= 0):
		print("Game Over")
		