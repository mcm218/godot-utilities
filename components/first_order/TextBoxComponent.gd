class_name TextBoxComponent extends Panel

@export var rich_text_label: RichTextLabel
@export var text: String
@export var delay_between_chars: float = 0.05

signal on_finished

var visible_on_start: bool = false
var current_index = 0
var current_text: String = ""

var is_playing: bool = false
var timer: float = 0.0
var has_run: bool = false

func _ready() -> void:
	visible = visible_on_start

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
    
	current_text = rich_text_label.text + text[current_index]
	current_index += 1
	rich_text_label.text = current_text

func _cleanup():
	visible = false
	var on_finished_timer = Timer.new()
	add_child(on_finished_timer)
	on_finished_timer.wait_time = 0.25
	on_finished_timer.one_shot = true
	on_finished_timer.timeout.connect(func (): on_finished.emit())
	on_finished_timer.start()

func play(_node: Node) -> void:
	if has_run || is_playing: return

	print_debug("PLAYING TEXT BOX")
	visible = true
	current_index = 0
	current_text = ""
	rich_text_label.text = ""
	timer = 0
	is_playing = true