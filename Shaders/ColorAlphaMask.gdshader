shader_type canvas_item;
render_mode blend_add;

uniform sampler2D source;
uniform vec4 target_color = vec4(0.0, 0.0, 1.0, 1.0);
uniform vec4 mask_found = vec4(1.0);
uniform vec4 mask_out = vec4(0.0);
uniform float tolerance = 0.1;




void fragment() {
	vec4 tex_color = texture(source, UV);
	
	COLOR = distance(tex_color, target_color) <= tolerance ? mask_found:mask_out;
}
