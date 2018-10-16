extends Node2D

enum Direction{
	UP,
	DOWN,
	LEFT,
	RIGHT
}

export(Direction) var moving_dir = UP
export(int) var movement_in_px = 0
export(float) var movement_duration = 0.2

func move_wall(is_pushed_in):
	var new_pos = position;
	var dir = get_moving_dir(is_pushed_in)
	if dir == UP :
		new_pos.y -= movement_in_px
	elif dir == DOWN:
		new_pos.y += movement_in_px
	elif dir == LEFT:
		new_pos.x -= movement_in_px
	elif dir == RIGHT:
		new_pos.x += movement_in_px
	$Tween.interpolate_property($".","position",position, new_pos, movement_duration, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()

func get_moving_dir(is_pushed_in):
	var dir = moving_dir
	if !is_pushed_in:
		if dir == UP :
			dir = DOWN
		elif dir == DOWN:
			dir = UP
		elif dir == LEFT:
			dir = LEFT
		elif dir == RIGHT:
			dir = RIGHT
	return dir

func _on_PressurePlate_pressure_plate_pushed(is_pushed_in):
	move_wall(is_pushed_in)
