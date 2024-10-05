class_name RepeaterComponent extends Node

@export var seconds_per_trigger: float = 1.0
signal on_trigger

var counter: float = 0.0

func _ready():
    counter = 0.0

func _process(delta):
    counter += delta
    if counter >= seconds_per_trigger:
        counter -= seconds_per_trigger
        on_trigger.emit()