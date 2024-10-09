class_name PaletteComponent extends CanvasLayer

@export var texture: Texture2D = load("../../../textures/palette")
@export var flip: bool = false
var sprite: Sprite2D

func _ready():
    sprite = Sprite2D.new()
    add_child(sprite)

    var loaded_material: ShaderMaterial = load("../../shaders/apply_palette.tres")
    if loaded_material is ShaderMaterial:
        loaded_material.set_shader_param("palette", texture)
        loaded_material.set_shader_param("flip", flip)
        sprite.material = loaded_material