shader_type canvas_item;
render_mode unshaded;

//uniform vec4 dot_color: hint_color;
uniform vec2 number = vec2(10.0, 10.0);
//uniform float add = 0.0;

uniform float progress : hint_range(0, 1) = 0.42;
uniform float diamondPixelSize = 10f;


void fragment() {
	highp float xFraction = fract(FRAGCOORD.x / diamondPixelSize);
    highp float yFraction = fract(FRAGCOORD.y / diamondPixelSize);
    
    highp float xDistance = abs(xFraction - 0.5);
    highp float yDistance = abs(yFraction - 0.5);
    
    if (xDistance + yDistance > progress * 2f) {
        COLOR.rgb = vec3(0.0);
    }
	else {
		COLOR.a = 0.0;
	}
}