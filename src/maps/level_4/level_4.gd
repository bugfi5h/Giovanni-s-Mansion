extends "res://maps/Map.gd"


func _ready():
	$AnimationPlayer.play("Fountain")

func change_image():
	$Picture.set_region_rect(Rect2(16,0,16,16))


func _on_Wall_set_tiles(coordinates, id):
	._on_Wall_set_tiles(coordinates, id)
