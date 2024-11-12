class_name GameStateComponent extends Node

# MOVE TO ENUMS FILE
enum GameState {
    # State when the game is running
	PLAYING,
    # State when the game is paused
	PAUSED,
}

@export var state: GameState = GameState.PLAYING

signal on_state_changed(state: GameState)


func pause():
    state = GameState.PAUSED
    emit_signal("on_state_changed", state)

func play():
    state = GameState.PLAYING
    emit_signal("on_state_changed", state)

func toggle():
    if state == GameState.PLAYING:
        pause()
    else:
        play()