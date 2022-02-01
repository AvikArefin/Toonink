shader_type canvas_item;

uniform vec4 dot_color: hint_color;
uniform vec2 number = vec2(5.0, 5.0);
uniform float add;


void fragment()
{
	vec2 uv = UV;
	uv *= number;
	
	vec2 i_uv = floor(uv);
	vec2 f_uv = fract(uv);
	
	vec2 center = f_uv*2.0 -1.0;
	float circle = length(center + add);
	
	COLOR = vec4(circle) * dot_color;
}