shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D palette : hint_default_black;
uniform bool flip ;

void fragment(){ 
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 new_color = vec4(.0);
	int palette_size = textureSize(palette, 0).x;
	for (int i = 0; i < palette_size; i++) {
		vec4 palette_color = texture(palette, vec2(1.0 / float(palette_size) * (float(i) + 0.5), .0));
		if (distance(palette_color, color) < distance(new_color, color)) {
			new_color = palette_color;
		}
	}
	
	COLOR = new_color;
}