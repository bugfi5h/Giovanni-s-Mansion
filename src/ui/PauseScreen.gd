extends CanvasLayer

func _process(delta):
	var pause = !get_tree().paused
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = pause
		$Container.visible = pause