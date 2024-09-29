class_name Attack

var attack_damage: int
var knockback_force: float
var attack_position: Vector2
	
func _init(damage: int, knockback_force: float, attack_position: Vector2) -> void:
	self.attack_damage = damage
	self.knockback_force = knockback_force
	self.attack_position = attack_position
