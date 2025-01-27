shader_type canvas_item;

uniform float box_r = 128.;
uniform float step_count = 8;

void fragment(){
	int step_size = int(max(1., box_r / (2. * step_count)));
	
	vec2 pixel = UV / TEXTURE_PIXEL_SIZE;
	int x_min = max(int(pixel.x-box_r), 0);
	int x_max = min(int(pixel.x+box_r), int(1./TEXTURE_PIXEL_SIZE.x));
	int y_min = max(int(pixel.y-box_r), 0);
	int y_max = min(int(pixel.y+box_r), int(1./TEXTURE_PIXEL_SIZE.y));
	vec4 total = vec4(0., 0., 0., 0.);
	for(int i = x_min; i < x_max; i += step_size){
		for(int j = y_min; j < y_max; j += step_size){
			total += texture(TEXTURE, vec2(float(i), float(j)) * TEXTURE_PIXEL_SIZE);
		}
	}
	total /= step_count * step_count;
	COLOR = total;
}
