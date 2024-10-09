class_name MovementComponent2D extends Node2D

@export var speed: float = 1.0
@export var tragectory: Vector2;

func _physics_process(delta):
    var velocity: Vector2 = _velocity();
    position.x += velocity.x * delta;
    position.y += velocity.y * delta;

func _velocity() -> Vector2:
    return speed * tragectory;
