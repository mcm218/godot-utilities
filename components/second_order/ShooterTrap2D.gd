class_name Trap2D extends Node2D

@onready var repeater: RepeaterComponent = $RepeaterComponent
@export var trigger: Trigger2DComponent
@export var requires_trigger: bool = false

@export var shot: PackedScene
@export var shot_speed: float = 1.0
@export var shot_tragectory: Vector2 = Vector2(1,0)

func _ready():
    if !repeater:
        print_debug("MISSING REPEATER COMPONENT")
        return
    
    if requires_trigger:
        repeater.pause()
        _load_trigger_node()
        if !trigger:
            print_debug("MISSING TRIGGER COMPONENT")
            return
        trigger.on_trigger.connect(_on_trigger)
        return

    repeater.on_trigger.connect(_shoot)
    repeater.play()
        
func _on_trigger():
    repeater.on_trigger.connect(_shoot)
    trigger.on_trigger.disconnect(_on_trigger)
    repeater.play()

func _shoot():
    var node: MovementComponent2D = shot.new()
    if not node is MovementComponent2D:
        print_debug("INVALID PACKED SCENE")
        node.queue_free()
        return
    
    node.speed = shot_speed
    node.tragectory = shot_tragectory
    add_child(node)

func _load_trigger_node():
    var children: Array[Node] = get_children()
    for child in children:
        if child is Trigger2DComponent:
            trigger = child
            break