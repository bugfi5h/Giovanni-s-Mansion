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
	set_limits()
	set_camera_limits()
	pass

func set_limits():
	var map_limits = $Ground.get_used_rect() 
	var map_cellsize = $Ground.cell_size
	
	left_limit = map_limits.position.x * map_cellsize.x
	right_limit = map_limits.end.x * map_cellsize.x
	top_limit = map_limits.position.y * map_cellsize.y
	bottom_limit = map_limits.end.y * map_cellsize.y

##TODO
func set_camera_limits():
	$Player/Camera2D.limit_left = left_limit
	$Player/Camera2D.limit_right = right_limit
	$Player/Camera2D.limit_top = top_limit
	$Player/Camera2D.limit_bottom = bottom_limit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  $Player.position.x< 8:
		$Player.position.x = 8
	if $Player.position.x + 8 > right_limit:
		$Player.position.x = right_limit - 8
	if $Player.position.y < 8:
		$Player.position.y = 8
	if $Player.position.y + 8 > bottom_limit:
		$Player.position.y = bottom_limit - 8
		
#	pass


func _on_Area2D_body_entered(body):
	if(body == $Player):
		$Wall.move_wall();
