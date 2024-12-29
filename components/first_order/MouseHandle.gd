class_name MouseHandle extends Node2D

@export var is_enabled: bool = true

signal on_click()
signal on_release()

var is_pressed: bool = false

func _process(_delta):
	if !is_pressed: return

	var mouse_global_position = get_global_mouse_position()
	position = mouse_global_position;

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed && is_mouse_over():
			is_pressed = true
			on_click.emit()
		elif is_pressed:
			is_pressed = false
			on_release.emit()

func is_mouse_over() -> bool:
	var mouse_global_position = get_global_mouse_position()
	return within_range(global_position, mouse_global_position, 50.0)


func within_range(a: Vector2, b: Vector2, distance: float) -> bool:
	return a.distance_to(b) <= distance;


func enable():
	is_enabled = true

func disable():
	is_enabled = false