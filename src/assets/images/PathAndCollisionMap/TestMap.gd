extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Wrath.nav = $Navigation2D
	print($Wall.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Wall_set_tiles(coordinates, id):
	var map = $Navigation2D/TileMap
	for coordinate in coordinates:
		var tile = map.world_to_map(coordinate)
		map.set_cell(tile.x, tile.y, id)
