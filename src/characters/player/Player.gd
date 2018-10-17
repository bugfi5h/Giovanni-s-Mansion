extends "res://characters/Character.gd"

signal lamp_health_changed(amount)
signal stamina_changed(amount)
signal player_moved(pos)

export(int) var lamp_decrease = 1
export(int) var lamp_timer_in_seconds = 3
export(int) var stamina_decrease = 1
export(int) var stamina_restoration = 5
export(int) var max_speed = 100
export(int) var max_sprint_speed = 200

const max_lamp_health = 100;
var stamina = 100
var lamp_health = 100
var start_texture_scale
var velocity = Vector2()


var globals
var anim = ""

onready var sprite = $Sprite

func _ready():
	globals = get_node("/root/globals")
	$LightAnimation.play("glow")
	start_texture_scale = $Lamp.texture_scale
	_set_oil_health(globals.player_oil)
	_set_stamina(globals.player_stamina)
	$LampTimer.wait_time = lamp_timer_in_seconds
	$LampTimer.start()
	$StaminaRestorationTimer.start()

func _physics_process(delta):
	control(delta)
	move_and_slide(velocity)
	play_animation()
	emit_signal("player_moved", position)

func control(delta):
	velocity = Vector2()
	var direction = Vector2()

	if Input.is_action_pressed('move_up'):
		direction = Vector2(0,-1)
	if Input.is_action_pressed('move_down'):
		direction = Vector2(0,1)
	if Input.is_action_pressed('move_left'):
		direction = Vector2(-1,0)
	if Input.is_action_pressed('move_right'):
		direction = Vector2(1,0)

	if Input.is_action_pressed('move_up') && Input.is_action_pressed('move_left'):
		direction = Vector2(-0.707,-0.707)
	if Input.is_action_pressed('move_up') && Input.is_action_pressed('move_right'):
		direction = Vector2(0.707,-0.707)
	if Input.is_action_pressed('move_down') && Input.is_action_pressed('move_left'):
		direction = Vector2(-0.707,0.707)
	if Input.is_action_pressed('move_down') && Input.is_action_pressed('move_right'):
		direction = Vector2(0.707,0.707)
	
	if Input.is_action_pressed('sprint') && stamina > 0 && direction.length() > 0:
		velocity = direction*max_sprint_speed
		decrease_stamina(stamina_decrease)
	else:
		velocity = direction*max_speed
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

func _set_oil_health(health):
	lamp_health = health
	update_lamp()
	globals.player_oil = lamp_health
	
func _on_LampTimer_timeout():
	_set_oil_health(lamp_health - lamp_decrease)
	
func add_lamp_health(amount):
	_set_oil_health(min(lamp_health + amount, max_lamp_health))

func decrease_lamp_health(amount):
	_set_oil_health(max(lamp_health - amount,0))
	
func update_lamp():
	var lamp_light = max(start_texture_scale * (lamp_health / 100.0), 0)
	$Lamp.texture_scale = lamp_light
	emit_signal("lamp_health_changed", lamp_health)
	if(lamp_light <= 0):
		globals.game_over()

func decrease_stamina(amount):
	_set_stamina(stamina - amount)
	pass
	
func increase_stamina(amount):
	_set_stamina(stamina + amount)
	pass

func _set_stamina(amount):
	if amount < 0:
		stamina = 0
	elif amount > 100:
		stamina = 100
	else:
		stamina = amount
	
	emit_signal("stamina_changed", stamina)
	globals.player_stamina = stamina
	pass;

func _on_StaminaRestorationTimer_timeout():
	increase_stamina(stamina_restoration)
