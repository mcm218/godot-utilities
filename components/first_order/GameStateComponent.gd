class_name GameStateComponent extends Node


var state: Enums.State = Enums.State.PLAYING

signal on_state_changed(state: Enums.State)


func pause():
    state = Enums.State.PAUSED
    print_debug("GameStateComponent: Paused")
    emit_signal("on_state_changed", state)

func play():
    state = Enums.State.PLAYING
    print_debug("GameStateComponent: Playing")
    emit_signal("on_state_changed", state)

func toggle():
    if state == GameState.PLAYING:
        pause()
    else:
        play()