extends Node2D

signal wrath_moved(pos)

var anim = ""
export(int) var speed = 50
var nav = null
var path = []
var goal = Vector2()
var new_path = true
var player = null
var player_class = preload("res://characters/player/Player.gd")
export(int) var damage = 3
export(bool) var should_follow_player = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_owner()
	if parent != null :
		nav = parent.get_node("Nav")
		if nav != null:
			print("done")
	emit_signal("wrath_moved", position)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_goal(new_goal):
	goal = new_goal
	update_path()
	
func update_path():
	if new_path:
		if nav != null:
			path = nav.get_simple_path(position, goal, false)
			new_path = false

func _physics_process(delta):
	if path.size() > 1:
		var distance_to_point = position.distance_to(path[0])
		if distance_to_point > 2 && should_follow_player:
			position = position.linear_interpolate(path[0], (speed * delta/distance_to_point))
			emit_signal("wrath_moved", position)
		else:
			path.remove(0)
	
	#Animation
	var new_anim = "idle"
	if new_anim != anim:
		anim = new_anim
		$SpriteAnimations.play(anim)


func _on_NewPath_timeout():
	new_path = true

func _on_Area2D_body_entered(body):
	if body is player_class:
		player = body
		$Timer.start()

func _on_Area2D_body_exited(body):
	if body is player_class:
		player = null
		$Timer.stop()

func _on_Timer_timeout():
	if player != null and player is player_class:
		player.decrease_lamp_health(damage)
