class_name LerpFollower extends Node2D

@export var target: Node2D
@export var speed: float = 1.0
@export var offset: Vector2 = Vector2.ZERO

func _process(delta):
	var target_position: Vector2 = target.position + offset
	position = lerp(position, target_position, speed * delta)