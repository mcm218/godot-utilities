class_name WeaponComponent2D extends MovementComponent2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack: AttackComponent = $AttackComponent
@onready var hitbox: Hitbox2DComponent = $Hitbox2DComponent

func _ready():
    hitbox.on_hit.connect(damage)

func damage(node):
    HealthComponent.TryAttackHealth(node, attack.Attack())

func play_attack():
    if has_sprite_frame("attack"): sprite.play("attack")

## Checks if the current aniamted sprite has a specific animation
func has_sprite_frame(animation_name: String):
    var frames: PackedStringArray = sprite.sprite_frame.get_animation_names()
    return frames.has(animation_name)

