class_name SpriteFaderComponent2D extends AnimatedSprite2D

# MOVE TO ENUMS FILE
enum FadeDirection {
	IN,
	OUT
}

func fade(direction: FadeDirection = FadeDirection.IN):
    if direction == FadeDirection.IN:
        play_backwards("fade")
    else:
        play("fade")