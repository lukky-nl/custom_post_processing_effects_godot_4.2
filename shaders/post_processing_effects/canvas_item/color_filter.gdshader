shader_type canvas_item;

uniform sampler2D screen_texture:hint_screen_texture,repeat_disable,filter_nearest;

void fragment() {
	vec3 color = texture(screen_texture,SCREEN_UV).rgb;
	color.g = 0.0;
	color.b = 0.0;
	COLOR.rgb = color;
}
