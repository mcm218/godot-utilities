class_name WorldHandle extends Node2D

@export var is_enabled: bool = true
@export var parent: Node2D
@export var targetType: String = ""

var player: CharacterBody2D
signal on_click(targetType: String)
signal on_release(targetType: String)

var is_pressed: bool = false

func _process(_delta):
	if !is_pressed || !is_enabled || !player: return

	parent.global_position = player.global_position

func _input(event: InputEvent) -> void:
	if is_enabled && event is InputEventKey && event.keycode == KEY_ENTER:
		if event.pressed && !event.is_echo():
			grab()
		elif is_pressed:
			release()

func enable(node: CharacterBody2D):
	if player: return

	player = node
	is_enabled = true
	if player.has_method("grabbed_item"):
		player.grabbed_item(targetType)

func disable(node: CharacterBody2D):
	if node == player:
		if player.has_method("dropped_item"):
			player.dropped_item(targetType)
		
		player = null
		is_enabled = false
		release()


func grab():
	is_pressed = true
	on_click.emit(targetType)

func release():
	is_pressed = false
	on_release.emit(targetType)
