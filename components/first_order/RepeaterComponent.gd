class_name RepeaterComponent extends Node
@export var seconds_per_trigger: float = 1.0
signal on_trigger

var timer: Timer

func _ready():
	timer = _init_timer()

func _on_timeout():
	on_trigger.emit()
	timer.start(seconds_per_trigger)

func play(): timer.paused = false
func pause(): timer.paused = true

func _init_timer() -> Timer:
	var new_timer = Timer.new()

	new_timer.one_shot = false
	new_timer.paused = true
	new_timer.timeout.connect(_on_timeout)
	add_child(new_timer)

	new_timer.start(seconds_per_trigger)
	return new_timer
