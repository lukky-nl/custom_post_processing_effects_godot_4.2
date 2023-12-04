shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

// Inspector params:
uniform float effect = -1.1; // -1.0 is BARREL, 0.1 is PINCUSHION. For planets, ideally -1.1 to -4.
uniform float effect_scale = 1.1; // Play with this to slightly vary the results.
uniform bool dynamic_crop = false; // Guesses the crop amount with an admittedly badly inaccurate formula.
uniform bool manual_crop = false; // Cut out the junk outside the sphere.]
uniform bool black_out_crop = true;
uniform float manual_amount = 0.95; // Higher value = more crop.
uniform float zoom = 1.0;

vec2 distort(vec2 p) {
	float d = length(p);
	float z = sqrt(1.0 + d * d * effect);
	float r = atan(d, z) / 3.14159;
	r *= effect_scale;
	float phi = atan(p.y, p.x);
	return vec2(r*cos(phi)+.5,r*sin(phi)+.5);
}

void fragment() {
	vec2 uv = SCREEN_UV;

	vec2 xy = (2.0 * uv);
	xy.x = xy.x - 1.0;
	xy.y = xy.y - 1.0;
	
	xy *= zoom;
	
	// Dynamic crop adjustment. -0.5 is equavalent to 'none'.
	float d_adjust = -0.5;
	if (dynamic_crop) {
		d_adjust = (effect/4.0) * -0.6;
	}

	// Perform distortion if needed.
	vec4 tex;
	float d = length(xy);
	if (d < 1.0 - d_adjust) {
		xy = distort(xy);

		tex = texture(SCREEN_TEXTURE, xy);
		COLOR.rgb = tex.rgb;
	}
	else {
		COLOR.a = 0.0;
	}

}