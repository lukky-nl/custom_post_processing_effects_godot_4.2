shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec4 tex = texture(SCREEN_TEXTURE, SCREEN_UV);
    vec3 greyScale = vec3(.5, .5, .5);
    COLOR = vec4( vec3(dot( tex.rgb, greyScale)), tex.a);
}