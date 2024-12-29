class_name PaletteComponent extends CanvasLayer

@export var texture: Texture2D = load("res://Hollow 1x.png")
@export var flip: bool = false
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	print_debug(texture)
	print_debug(flip)
	print_debug(sprite)
	var shader: Shader = load("res://utilities/shaders/apply_palette.gdshader")
	print_debug(shader)
	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader;
	material.set_shader_parameter("palette", texture)
	material.set_shader_parameter("flip", flip)
	sprite.material = material
