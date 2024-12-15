class_name Handle extends Node2D

signal on_click()
signal on_release()

var is_pressed: bool = false

func _process(_delta):
	if !is_pressed: return

	var mouse_global_position = get_global_mouse_position()
	position = mouse_global_position;

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_pressed = true
			on_click.emit()
		else:
			is_pressed = false
			on_release.emit()