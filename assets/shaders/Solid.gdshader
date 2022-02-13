shader_type canvas_item;
render_mode unshaded;

uniform vec4 _color : hint_color;

void fragment() {
	COLOR = _color;
}