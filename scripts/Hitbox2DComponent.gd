class_name Hitbox2DComponent extends Area2D

signal on_hit(attack: Attack)
@export var health_component: HealthComponent

func damage(attack: Attack):
	if health_component:
		on_hit(attack)
		health_component.damage(attack)
