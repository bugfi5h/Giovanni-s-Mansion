extends "res://characters/Character.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var anim = ""
export(int) var speed = 150
var nav = null
var path = []
var goal = Vector2()
var new_path = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
		if distance_to_point > 2:
			position = position.linear_interpolate(path[0], (speed * delta/distance_to_point))
		else:
			path.remove(0)
	
	#Animation
	var new_anim = "idle"
	if new_anim != anim:
		anim = new_anim
		$SpriteAnimations.play(anim)


func _on_NewPath_timeout():
	new_path = true
