extends Node2D

enum Direction{
	UP,
	DOWN,
	LEFT,
	RIGHT
}

signal set_tile(coordinates, id)
signal pressure_plate_pushed(is_pushed_in)
signal wall_starts_moving()
signal wall_ended_moving()
var used_cells

func _ready():
	used_cells = $TileMap.get_used_cells()
	set_occupied_coords()

func set_occupied_coords():
	for cell_pos in used_cells:
		var x = cell_pos.x * 16
		var y = cell_pos.y * 16
		var id = $TileMap.get_cellv(cell_pos)
		emit_signal("set_tile",Vector2(x + $TileMap.global_position.x, y + $TileMap.global_position.y),id)

func clear_occupied_coords():
	for cell_pos in used_cells:
		var x = cell_pos.x * 16
		var y = cell_pos.y * 16
		emit_signal("set_tile",Vector2(x + $TileMap.global_position.x, y + $TileMap.global_position.y),0)

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
	clear_occupied_coords()
	$Tween.interpolate_property($".","position",position, new_pos, movement_duration, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	emit_signal("wall_starts_moving")

func get_moving_dir(is_pushed_in):
	var dir = moving_dir
	if !is_pushed_in:
		if dir == UP :
			dir = DOWN
		elif dir == DOWN:
			dir = UP
		elif dir == LEFT:
			dir = RIGHT
		elif dir == RIGHT:
			dir = LEFT
	return dir

func _on_pressure_plate_pushed(is_pushed_in):
	move_wall(is_pushed_in)
	emit_signal("pressure_plate_pushed",is_pushed_in)
	
func _on_Tween_tween_completed(object, key):
	set_occupied_coords()
	emit_signal("wall_ended_moving")

