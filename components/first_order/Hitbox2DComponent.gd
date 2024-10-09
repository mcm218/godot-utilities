class_name Hitbox2DComponent extends Area2D

signal on_hit(body: PhysicsBody2D)
signal on_hit_area(area: Area2D)

func _ready():
	monitoring = true
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)


func _on_area_entered(node: Area2D):
	on_hit_area.emit(node)

func _on_body_entered(node):
	if node is PhysicsBody2D:
		on_hit.emit(node)
	
