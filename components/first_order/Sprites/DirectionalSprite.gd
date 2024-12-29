class_name DirectionalSprite extends Node2D

@export var target: AnimatedSprite2D
@export var use_diagonals: bool = false
@export var VERTICAL_TOLERANCE: float = 0
@export var HORIZONTAL_TOLERANCE: float = 0.25
@export var debug: bool = false

var num_avg: int = 5
var avg_diffs: Array[Vector2] = []
var old_position: Vector2

func _ready():
	old_position = global_position

	if !target:
		target = get_parent()

func update_avg(new_diff: Vector2):
	if avg_diffs.size() >= num_avg:
		avg_diffs.pop_back()
	
	avg_diffs.push_front(new_diff)

func get_avg_diff() -> Vector2:
	var sum = Vector2(0,0)
	for curr in avg_diffs:
		sum += curr
	
	return sum / avg_diffs.size()

func _process(_delta):
	var new_position = global_position;

	var diff = (new_position - old_position).normalized()
	update_avg(diff)
	var avg_diff: Vector2 = get_avg_diff()

	var is_up = avg_diff.y > VERTICAL_TOLERANCE
	var is_down = avg_diff.y < -VERTICAL_TOLERANCE
	var is_left = avg_diff.x < -HORIZONTAL_TOLERANCE
	var is_right = avg_diff.x > HORIZONTAL_TOLERANCE

	if is_up && debug: print_debug(name + ": up")
	if is_down && debug: print_debug(name + ": down")
	if is_left && debug: print_debug(name + ": left")
	if is_right && debug: print_debug(name + ": right")

	if use_diagonals:
		if is_up && is_left: target.play("up left")
		elif is_up && is_right: target.play("up right")
		elif is_up: target.play("up")

		elif is_down && is_left: target.play("down left")
		elif is_down && is_right: target.play("down right")

		elif is_down: target.play("down")
		elif is_left: target.play('left')
		elif is_right: target.play('right')

		else: target.play("idle")
	else:
		if is_left: target.play('left')
		elif is_right: target.play('right')
		elif is_up: target.play("up")
		elif is_down: target.play('down')
		else: target.play("idle")

	old_position = new_position
