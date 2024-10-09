class_name Attack

var attack_damage: int
var attack_knockback_force: float
var attack_position: Vector2
	
func _init(damage: int, knockback_force: float, position: Vector2) -> void:
	self.attack_damage = damage
	self.attack_knockback_force = knockback_force
	self.attack_position = position
