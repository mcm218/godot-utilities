class_name StaticTrap2D extends Node2D

@onready var trigger: Trigger2DComponent = $Trigger2DComponent
@onready var attack: AttackComponent = $AttackComponent
@export var is_single_use: bool = false

func _ready():
    trigger.on_trigger.connect(_on_trigger)

func _on_trigger(node):
    var attacked: bool = HealthComponent.TryAttackHealth(node, attack.Attack())
    if attacked && is_single_use:
        queue_free()