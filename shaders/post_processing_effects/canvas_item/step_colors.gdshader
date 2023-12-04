
shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

uniform int steps_per_color = 2;


void fragment() {
	vec2 uv = SCREEN_UV;
	vec4 screen_color = texture(SCREEN_TEXTURE, uv);
	
	float red = round((screen_color.r)*float(steps_per_color))/float(steps_per_color);
	float green = round((screen_color.g)*float(steps_per_color))/float(steps_per_color);
	float blue = round((screen_color.b)*float(steps_per_color))/float(steps_per_color);
	COLOR.rgb = vec3(red,green,blue);
	
}