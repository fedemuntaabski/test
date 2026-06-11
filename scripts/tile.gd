extends Area2D

signal tile_clicked(index)

@export var index: int

func _input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_click"):
		tile_clicked.emit(index)