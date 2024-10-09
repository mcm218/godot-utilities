class_name SpearTrap2D extends Node2D

@onready var trigger: Trigger2DComponent = $Trigger2DComponent
@onready var weapon: WeaponComponent2D = $WeaponComponent2D
@onready var follower: Follower2DComponent = $Follower2DComponent
@onready var path: Path2D = $Path2D

var is_active: bool = false

func _ready():
    trigger.on_trigger.connect(_on_trigger)

    # Setup weapon to follow a path
    follower.add_child(weapon)
    path.add_child(follower)

    follower.is_paused = true
    follower.on_loop_completed.connect(_on_loop_completed)
    follower._on_half_loop_completed.connect(_on_half_loop_completed)

func _on_loop_completed():
    is_active = false
    follower.reset_and_pause()

func _on_trigger():
    if is_active: return

    is_active = true
    follower.is_paused = false
    follower.loops = false
    follower.returns = true

    weapon.play_attack()

func _on_half_loop_completed():
    weapon.play_attack();