shader_type spatial;
render_mode unshaded;


uniform sampler2D NORMAL_TEXTURE : hint_normal_roughness_texture, filter_nearest;
uniform sampler2D depth_texture : source_color, hint_depth_texture;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

uniform float intencity = 0.2;

void vertex(){
	POSITION = vec4(VERTEX, 1.0);
}

void fragment() {
	float Shift_Hue = TIME;
	vec3 normal = texture(NORMAL_TEXTURE,SCREEN_UV).rgb;
	
	ALBEDO = normal;
	
	vec3 input_color;
	vec4 texture_color = texture(NORMAL_TEXTURE, SCREEN_UV);
	input_color = texture_color.rgb;

// VectorFunc:2
	vec3 color_hsv;
	{
		vec3 c = input_color;
		vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
		vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
		vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
		float d = q.x - min(q.w, q.y);
		float e = 1.0e-10;
		color_hsv=vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
	}

	color_hsv.x = mod((color_hsv.x + Shift_Hue), 1.0f);

// VectorFunc:5
	vec3 color_rgb;
	{
		vec3 c = color_hsv;
		vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
		vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
		color_rgb=c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
	}

// Output:0
	texture_color = vec4(color_rgb.rgb,texture_color.a);
	ALBEDO = texture_color.rgb - vec3(intencity) * vec3(0.8);
}