shader_type canvas_item;

uniform sampler2D screen_texture:hint_screen_texture,repeat_disable,filter_nearest;
uniform sampler2D noise_texture:repeat_enable;

void fragment() {
	vec3 noise_color = texture(noise_texture,SCREEN_UV + (TIME / 10.0)).rgb;
	vec3 color = texture(screen_texture,SCREEN_UV + (noise_color.b / 20.0)).rgb;
	COLOR.rgb = color;
}
