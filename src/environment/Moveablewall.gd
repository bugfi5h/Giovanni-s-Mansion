extends Node2D

enum Direction{
	UP,
	DOWN,
	LEFT,
	RIGHT
}

signal set_tiles(coordinates, id)
var used_cells

func _ready():
	used_cells = $TileMap.get_used_cells()
	emit_signal("set_tiles",get_occupied_coords(), 0)

func get_occupied_coords():
	var occupied_global_cells = []
	for cells in used_cells:
		var x = cells.x * 16
		var y = cells.y * 16
		print("GLOBAL")
		print($TileMap.global_position)
		occupied_global_cells.append(Vector2(x + $TileMap.global_position.x, y + $TileMap.global_position.y))
	return occupied_global_cells

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
	emit_signal("set_tiles", get_occupied_coords(), 1)

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
	
func _on_Tween_tween_completed(object, key):
	emit_signal("set_tiles",get_occupied_coords(), 0)
