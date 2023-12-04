shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

uniform int levels = 3;
uniform float spread = 0.01;

vec3 chromatic_slice(float t){
	vec3 res = vec3(1.0-t, 1.0 - abs(t - 1.0), t - 1.0);
	return max(res, 0.0);
}

void fragment(){
	vec3 sum;
	COLOR.rgb = vec3(0);
	vec2 offset = (UV - vec2(0.5))*vec2(1,-1);
	for(int i = 0; i < levels; i++){
		float t = 2.0*float(i)/float(levels-1); // range 0.0->2.0
		vec3 slice = vec3(1.0-t, 1.0 - abs(t - 1.0), t - 1.0);
		slice = max(slice, 0.0);
		sum += slice;
		vec2 slice_offset = (t-1.0)*spread*offset;
		COLOR.rgb += slice * texture(SCREEN_TEXTURE, SCREEN_UV + slice_offset).rgb;
	}
}