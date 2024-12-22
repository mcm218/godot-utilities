class_name VariableMagnitudePull extends Node2D

signal on_release(strength: float, direction: Vector2)
signal on_strength_change(strength: float)
signal on_direction_change(direction: Vector2)

@export var handle: Handle

@export var strength: float = 0
@export var direction: Vector2

var is_holding: bool = false

func _ready():
	if !handle:
		push_error("handle must be set")

	handle.on_click.connect(_on_handle_clicked)
	handle.on_release.connect(_on_handle_released)

func _on_handle_clicked():
	print_debug("handle clicked")
	is_holding = true

func _on_handle_released():
	print_debug("handle released")
	print_debug("strength: " + str(strength))
	print_debug("direction: " + str(direction))
	on_release.emit(strength, direction)

	is_holding = false
	strength = 0
	direction = Vector2(0,0)
	handle.position = position


func _process(_delta):
	if !is_holding: return

	strength = get_strength()
	direction = get_direction()

	on_strength_change.emit(strength)
	on_direction_change.emit(direction)
	

func get_strength() -> float:
	return (abs(position - handle.position)).length()

func get_direction() -> Vector2:
	return -(handle.position - position)