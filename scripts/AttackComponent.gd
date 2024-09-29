class_name AttackComponent extends Node

@export var attack_damage: int = 1
@export var attack_knockback_force: float = 10

func attack() -> Attack:
    var attack_position: Vector2 = get_parent().position
    return Attack.new(attack_damage, attack_knockback_force, attack_position)