class_name TopdownController extends CharacterBody2D

@export var speed: float = 1.0

func _physics_process(_delta):
	var direction_vector: Vector2 = _get_input_vector()
	velocity = direction_vector * speed
	move_and_slide()

func _get_input_vector() -> Vector2:
	var direction_vector: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		direction_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		direction_vector.y += 1
	if Input.is_action_pressed("move_left"):
		direction_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		direction_vector.x += 1
	return direction_vector