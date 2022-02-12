shader_type canvas_item;
uniform sampler2D tex;


void fragment() {
	vec4 tex_read = texture(tex, UV.xy);
	vec3 n_out3p0 = tex_read.rgb;
	float n_out3p1 = tex_read.a;

	COLOR.rgb = n_out3p0;

}