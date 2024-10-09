class_name Projectile2D extends MovementComponent2D

@onready var hitbox: Hitbox2DComponent = $Hitbox2DComponent
@onready var attack: AttackComponent = $AttackComponent

func _ready():
    hitbox.on_hit.connect(_damage_body)

func _damage_body(node):
    var attacked = HealthComponent.TryAttackHealth(node, attack.Attack())
    if attacked:
        queue_free()