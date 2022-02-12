shader_type canvas_item;
render_mode unshaded;

uniform float cell_size = 16;
uniform float cell_spacing = 2;
uniform vec4 line_color : hint_color;

varying vec2 v;

void vertex() {
	v = VERTEX;
}

void fragment() {
	COLOR.a = 0.;
	float step_size = cell_size + cell_spacing;
	float ratio = cell_spacing / step_size;
	// Grid
	if (fract(v.y / step_size) < ratio) COLOR = line_color;
}