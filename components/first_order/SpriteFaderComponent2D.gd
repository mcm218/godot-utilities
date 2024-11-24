class_name SpriteFaderComponent2D extends AnimatedSprite2D

# MOVE TO ENUMS FILE
enum FadeDirection {
	IN,
	OUT
}

signal on_fade_in_finished
signal on_fade_out_finished

@export var play_on_start: bool = false
@export var pause_game_on_start: bool = false

func _ready():
    if play_on_start:
        fade()

    if pause_game_on_start:
        GameState.pause()

func fade(direction: FadeDirection = FadeDirection.IN):
    if direction == FadeDirection.IN:
        fade_in()
    else:
        fade_out()


func fade_in(_garbage: Node = null):
    visible = true
    animation_finished.connect(fade_in_finished)
    play("fade")

func fade_out(_garbage: Node = null):
    visible = true
    animation_finished.connect(fade_out_finished)
    play_backwards("fade")


func fade_in_finished():
    GameState.play()
    on_fade_in_finished.emit()
    animation_finished.disconnect(fade_in_finished)


func fade_out_finished():
    GameState.pause()
    on_fade_out_finished.emit()
    animation_finished.disconnect(fade_out_finished)
