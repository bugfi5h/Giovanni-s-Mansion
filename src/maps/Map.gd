extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var left_limit = 0
var right_limit = 0
var top_limit = 0
var bottom_limit = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_camera_limits()
	pass

##TODO
func set_camera_limits():
	var map_limits = $Ground.get_used_rect() 
	var map_cellsize = $Ground.cell_size
	
	left_limit = map_limits.position.x * map_cellsize.x
	right_limit = map_limits.end.x * map_cellsize.x
	top_limit = map_limits.position.y * map_cellsize.y
	bottom_limit = map_limits.end.y * map_cellsize.y
	print(left_limit)
	print(right_limit)
	print(top_limit)
	print(bottom_limit)
	$Player/Camera2D.limit_left = left_limit
	$Player/Camera2D.limit_right = right_limit
	$Player/Camera2D.limit_top = top_limit
	$Player/Camera2D.limit_bottom = bottom_limit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.position.x < 7:
		$Player.position.x = 7
	if $Player.position.x + 7 > right_limit:
		$Player.position.x = right_limit - 7
	if $Player.position.y < 7:
		$Player.position.y = 7
	if $Player.position.y + 7 < bottom_limit:
		$Player.position.y = bottom_limit - 7
		
#	pass
