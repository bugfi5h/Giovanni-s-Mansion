extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal scene_changed(new_scene)
signal game_over()

var player_oil = 100
var player_stamina = 100
var stage = 0

var current_scene = null

var stages = ["res://maps/level_1/Level_1.tscn", "res://maps/level_3/level_3.tscn", "res://maps/level_4/level_4.tscn", "res://maps/level_2/Level_2.tscn"]

func _ready():
        var root = get_tree().get_root()
        current_scene = root.get_child(root.get_child_count() -1)

func get_display_stage_level():
	return String(stage + 1)

func get_current_scene():
	return current_scene

func game_over():
	emit_signal("game_over")
	goto_scene("res://ui/GameOver.tscn")

func reset_game():
	stage = 0
	player_oil = 100
	player_stamina = 100

func goto_main_menu():
	reset_game()
	goto_scene("res://ui/MainMenu.tscn")
	
func goto_credits():
	goto_scene("res://ui/Credits.tscn")

func goto_next_floor():
	if(stages.size() > stage):
		var path = stages[stage]
		stage = stage + 1
		goto_scene(path)
	else:
		handle_win()
		

func handle_win():
	goto_scene("res://ui/WinScreen.tscn")
	pass

func goto_scene(path):
    # This function will usually be called from a signal callback,
    # or some other function from the running scene.
    # Deleting the current scene at this point might be
    # a bad idea, because it may be inside of a callback or function of it.
    # The worst case will be a crash or unexpected behavior.

    # The way around this is deferring the load to a later time, when
    # it is ensured that no code from the current scene is running:

    call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
    # Immediately free the current scene,
    # there is no risk here.
    current_scene.free()

    # Load new scene.
    var s = ResourceLoader.load(path)

    # Instance the new scene.
    current_scene = s.instance()

    # Add it to the active scene, as child of root.
    get_tree().get_root().add_child(current_scene)

    # Optional, to make it compatible with the SceneTree.change_scene() API.
    get_tree().set_current_scene(current_scene)
    emit_signal("scene_changed", current_scene)