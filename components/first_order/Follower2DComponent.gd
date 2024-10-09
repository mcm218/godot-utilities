class_name Follower2DComponent extends PathFollow2D

@export var speed: float = 1.0
@export var loops: bool = true
@export var returns: bool = true
@export var is_paused: bool = true
@export var delay_before_returning: float = 0
@export var delay_before_looping: float = 0

var old_pos: Vector2
var moving_forward: bool = true
var loop_count: int = 0
var returning_delay_counter: float = 0
var looping_delay_counter: float = 0

signal _on_loop_completed
signal _on_half_loop_completed

func _ready():
    old_pos = position

func _process(delta):
    if is_paused: return

    if (loop_count == 0 || loops) && moving_forward && progress_ratio < 1:
        if returning_delay_counter >= delay_before_returning: progress += delta * speed
        else: returning_delay_counter += delta
    elif returns && not moving_forward && progress_ratio > 0:
        if looping_delay_counter >= delay_before_looping: progress -= delta * speed
        else: looping_delay_counter += delta

    old_pos = position
    if progress_ratio == 1:
        moving_forward = false
        _on_half_loop_completed.emit()

        returning_delay_counter = 0
    elif progress_ratio == 0:
        moving_forward = true
        _on_loop_completed.emit()
        
        loop_count += 1
        looping_delay_counter = 0

func reset_and_pause():
    moving_forward = true
    progress_ratio = 0
    loop_count = 0;
    old_pos = position
    
    is_paused = true