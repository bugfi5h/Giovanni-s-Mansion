extends Node

const MoveableWall = preload("res://environment/Moveablewall.gd")
const Lamp = preload("res://collectables/Lamp.gd")
const PressurePlate = preload("res://environment/PressurePlate.gd")
const Stairs = preload("res://environment/Stairs.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	var globals = get_node("/root/globals")
	globals.connect("scene_changed", self, "_on_scene_changed")
	globals.connect("game_over", self, "_play_game_over")
	connect_nodes(globals.current_scene)

func _on_scene_changed(new_scene):
	connect_nodes(new_scene)

func connect_nodes(scene: Node):
	var children = scene.get_children()
	for child in children:
		connect_nodes(child)
		if child is MoveableWall:
			child.connect("wall_starts_moving", self, "_play_move_wall")
			child.connect("wall_ended_moving", self, "_stop_move_wall")
		elif child is Button || child is TextureButton:
			child.connect("pressed", self, "_play_button_click")
		elif child is Lamp:
			child.connect("collected", self, "_play_fill_lamp")
		elif child is PressurePlate:
			child.connect("pressure_plate_pushed", self, "_play_pressure_plate")
		elif child is Stairs:
			child.connect("player_uses_stairs", self, "_play_stairs")

func _play_game_over():
	$GameOver.play()

func _play_move_wall():
	$MoveWall.play()

func _stop_move_wall():
	$MoveWall.stop()

func _play_button_click():
	$ButtonClick.play()

func _play_fill_lamp():
	$FillLamp.play()

func _play_stairs():
	$Stairs.play()

func _play_pressure_plate(pushed_in: bool):
	if pushed_in:
		$PressurePlate_On.play()
	else:
		$PressurePlate_Off.play()