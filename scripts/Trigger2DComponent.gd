class_name Trigger2DComponent extends Area2D

signal on_trigger(body: Node)

func _on_body_entered(body: Node) -> void:
	emit_signal("triggered", body)