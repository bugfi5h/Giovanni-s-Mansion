extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_oil = 100
var stage = 0

var current_scene = null

var stages = ["res://maps/Map.tscn"]

func _ready():
        var root = get_tree().get_root()
        current_scene = root.get_child(root.get_child_count() -1)

func get_display_stage_level():
	return String(stage + 1)

func game_over():
	stage = 0
	goto_scene("res://ui/GameOver.tscn")

func goto_next_floor():
	if(stages.count() > stage):
		var path = stages[stage]
		stage = stage + 1
		goto_scene(path)
		

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