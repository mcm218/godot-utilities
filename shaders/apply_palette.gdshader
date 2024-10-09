shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D palette : hint_default_black;
uniform bool flip ;

void fragment(){ 
	vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	float lum = dot(col.rgb,vec3(0.2126,0.7152,0.0722)); // luminance
	
	col = texture(palette,vec2(abs(float(flip) - lum),0));
	
	COLOR = col;
}