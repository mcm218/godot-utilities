class_name HealthComponent extends Node

var health: int = 6
@export var max_health: int = 6


func _ready():
	health = max_health

func damage(attack: Attack) -> void:
	health -= attack.attack_damage
	if health <= 0:
		health = 0
		get_parent().queue_free()
