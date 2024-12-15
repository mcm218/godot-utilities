class_name TopdownController extends CharacterBody2D

@export var speed: float = 1.0
var is_paused: bool = false

func _ready():
	GameState.on_state_changed.connect(_on_game_state_changed)
	is_paused = GameState.state == Enums.State.PAUSED

func _on_game_state_changed(state: Enums.State):
	if state == Enums.State.PAUSED:
		velocity = Vector2.ZERO
		is_paused = true
	else:
		is_paused = false

func _physics_process(_delta):
	if is_paused: return
	
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
	return direction_vector.normalized()
