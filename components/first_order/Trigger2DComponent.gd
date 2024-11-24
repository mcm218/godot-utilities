class_name Trigger2DComponent extends Area2D

signal on_trigger(body: Node)
signal on_trigger_base()

@export var player_only: bool = false
@export var pause_on_trigger: bool = false
@export var one_shot: bool = false


var num_triggers: int = 0;

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if (one_shot && num_triggers > 0) || (player_only && !body.get_groups().has("player")):
		return
	
	print_debug("TRIGGERED BY " + body.name);
	emit_signal("on_trigger", body)
	emit_signal("on_trigger_base")
	if pause_on_trigger:
		GameState.pause()

	num_triggers += 1