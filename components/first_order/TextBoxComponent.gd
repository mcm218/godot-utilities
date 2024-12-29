class_name TextBoxComponent extends Panel

@export var rich_text_label: RichTextLabel
@export var text: String
@export var delay_between_chars: float = 0.05
@export var speech_sfx: AudioStream;
@export var speaker_pitch_shift: float = 1.0
@export var font_size: int = 20;
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

signal on_finished
signal on_start

var visible_on_start: bool = false
var current_index = 0
var current_text: String = ""

var is_playing: bool = false
var timer: float = 0.0
var has_run: bool = false

func _ready() -> void:
	visible = visible_on_start
	audio_player.stream = speech_sfx

func _process(delta: float) -> void:
	if is_playing:
		timer += delta
		if timer >= delay_between_chars:
			timer -= delay_between_chars
			next_character()

func next_character():
	if current_index >= text.length():
		has_run = true
		is_playing = false
		var cleanup_timer = Timer.new()
		add_child(cleanup_timer)
		cleanup_timer.wait_time = 0.5
		cleanup_timer.one_shot = true
		cleanup_timer.timeout.connect(_cleanup)
		cleanup_timer.start()
		return
	
	var next_char = text[current_index]
	current_text = rich_text_label.text + next_char
	current_index += 1
	rich_text_label.text = current_text

	if is_char_not_space(next_char) && speech_sfx && !audio_player.playing:
		audio_player.pitch_scale = randf_range(0.9, 1.1) + speaker_pitch_shift
		audio_player.play()

func _cleanup():
	visible = false
	var on_finished_timer = Timer.new()
	add_child(on_finished_timer)
	on_finished_timer.wait_time = 0.1
	on_finished_timer.one_shot = true
	on_finished_timer.timeout.connect(func (): 
		on_finished.emit()
		GameState.play()
	)
	on_finished_timer.start()

func play(_node: Node = null) -> void:
	if has_run || is_playing: return

	print_debug("PLAYING TEXT BOX")
	GameState.pause();
	visible = true	
	current_index = 0
	current_text = "";
	rich_text_label.text = "[font_size=" + str(font_size) + "][color=white]";
	print_debug((rich_text_label.text))
	timer = 0
	is_playing = true


var char_regex: RegEx = RegEx.new()

func is_char_not_space(input: String) -> bool:
	char_regex.compile("^[a-zA-Z0-9]$")
	return char_regex.search(input) != null
