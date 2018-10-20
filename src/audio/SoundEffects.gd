extends Node

const MoveableWall = preload("res://environment/Moveablewall.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/globals").connect("scene_changed", self, "_on_scene_changed")


func _on_scene_changed(new_scene):
	connect_movable_walls(new_scene)

func connect_movable_walls(scene: Node):
	var children = scene.get_children()
	for child in children:
		connect_movable_walls(child)
		if child is MoveableWall:
			child.connect("wall_starts_moving", self, "_play_move_wall")
			child.connect("wall_ended_moving", self, "_stop_move_wall")

func _play_game_over():
	$GameOver.play()

func _on_MovableWall_moves(a):
	_play_move_wall()

func _play_move_wall():
	$MoveWall.play()
	
func _stop_move_wall():
	$MoveWall.stop()
	
func _play_button_click():
	$ButtonClick.play()

#func _play_move_wall():
#	$MoveWall.play()
#
#func _play_move_wall():
#	$MoveWall.play()
