shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

uniform int radius = 5;
uniform vec3 offset=vec3(0.0);
void fragment() 
 {
     vec2 src_size = vec2 ( 0.001, 0.001);
     vec2 uv = SCREEN_UV;
     float n = float((radius + 1) * (radius + 1));
     vec3 m0 = offset; vec3 m1 = offset; vec3 m2 = offset; vec3 m3 = offset;
     vec3 s0 = offset; vec3 s1 = offset; vec3 s2 = offset; vec3 s3 = offset;
     vec3 c;

     for (int j = -radius; j <= 0; ++j)  {
         for (int i = -radius; i <= 0; ++i)  {
             c = texture(SCREEN_TEXTURE, uv + vec2(float(i),float(j)) * src_size).rgb;
             m0 += c;
             s0 += c * c;
         }
     }

     for (int j = -radius; j <= 0; ++j)  {
         for (int i = 0; i <= radius; ++i)  {
             c = texture(SCREEN_TEXTURE, uv + vec2(float(i),float(j)) * src_size).rgb;
             m1 += c;
             s1 += c * c;
         }
     }

     for (int j = 0; j <= radius; ++j)  {
         for (int i = 0; i <= radius; ++i)  {
             c = texture(SCREEN_TEXTURE, uv + vec2(float(i),float(j)) * src_size).rgb;
             m2 += c;
             s2 += c * c;
         }
     }

     for (int j = 0; j <= radius; ++j)  {
         for (int i = -radius; i <= 0; ++i)  {
             c = texture(SCREEN_TEXTURE, uv + vec2(float(i),float(j)) * src_size).rgb;
             m3 += c;
             s3 += c * c;
         }
     }


     float min_sigma2 = 1e+2;
     m0 /= n;
     s0 = abs(s0 / n - m0 * m0);

     float sigma2 = s0.r + s0.g + s0.b;
     if (sigma2 < min_sigma2) {
         min_sigma2 = sigma2;
         COLOR.rgb = vec4(m0, 1.0).rgb;
     }

     m1 /= n;
     s1 = abs(s1 / n - m1 * m1);

     sigma2 = s1.r + s1.g + s1.b;
     if (sigma2 < min_sigma2) {
         min_sigma2 = sigma2;
         COLOR.rgb = vec4(m1, 1.0).rgb;
     }

     m2 /= n;
     s2 = abs(s2 / n - m2 * m2);

     sigma2 = s2.r + s2.g + s2.b;
     if (sigma2 < min_sigma2) {
         min_sigma2 = sigma2;
         COLOR.rgb = vec4(m2, 1.0).rgb;
     }

     m3 /= n;
     s3 = abs(s3 / n - m3 * m3);

     sigma2 = s3.r + s3.g + s3.b;
     if (sigma2 < min_sigma2) {
         min_sigma2 = sigma2;
         COLOR.rgb = vec4(m3, 1.0).rgb;
     }
 }