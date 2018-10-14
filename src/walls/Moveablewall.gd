extends KinematicBody2D

enum Direction{
	UP,
	DOWN,
	LEFT,
	RIGHT
}

export(Direction) var moving_dir = UP
export(int) var movement_in_px = 0
export(float) var movement_duration = 0.2

func move_wall():
	var new_pos = position;
	if moving_dir == UP :
		new_pos.y -= movement_in_px
	elif moving_dir == DOWN:
		new_pos.y += movement_in_px
	elif moving_dir == LEFT:
		new_pos.x -= movement_in_px
	elif moving_dir == RIGHT:
		new_pos.x += movement_in_px
	$Tween.interpolate_property($".","position",position, new_pos, movement_duration, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()

		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
