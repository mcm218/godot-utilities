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


static func FindHealthComponent(node: Node) -> HealthComponent:
	if node is HealthComponent: return node
	var children: Array[Node] = node.get_children()
	for child in children:
		FindHealthComponent(child)
	return

static func TryAttackHealth(node: Node, attack: Attack) -> bool:
	var healthComponent: HealthComponent = FindHealthComponent(node)
	if healthComponent: 
		healthComponent.attack(attack)
		return true
	return false
