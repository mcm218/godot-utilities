class_name BGMAssistComponent extends AudioStreamPlayer

@export var stopped_volume_db_offset: float = -30.0
var _original_volume_db: float
var _stopped_volume_db: float = -30
@export var _transition_duration: float = 2
var _transition_progress: float = 0.0
var _is_stopping: bool = false
var _is_starting: bool = false

func _ready():
	_original_volume_db = volume_db
	_stopped_volume_db = volume_db + stopped_volume_db_offset;

func _process(delta: float) -> void:
	if _transition_progress > _transition_duration: return

	if _is_starting || _is_stopping:
		_transition_progress += delta

	if _is_starting:
		var progress: float = clamp(_transition_progress / _transition_duration, 0, 1)
		volume_db = lerp(_stopped_volume_db, _original_volume_db, progress)
		if progress >= 1:
			_is_starting = false

	if _is_stopping:
		var progress: float =  1 - clamp(1 - (_transition_progress / _transition_duration), 0, 1)
		volume_db = lerp(_original_volume_db, _stopped_volume_db, progress)
		if progress >= 1:
			_is_stopping = false
			playing = false

func smooth_play():
	if _is_starting || playing: return;

	_is_starting = true
	_is_stopping = false
	volume_db = _stopped_volume_db
	_transition_progress = 0
	playing = true

func smooth_stop():
	if _is_stopping || !playing: return
	
	_is_stopping = true
	_is_starting = false
	_transition_progress = 0