class_name Trigger2DComponent extends Area2D

signal on_trigger(body: Node)

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	print_debug("TRIGGERED BY " + body.name);
	emit_signal("on_trigger", body)