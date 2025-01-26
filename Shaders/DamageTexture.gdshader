shader_type canvas_item;
/*
This shader takes two textures and draws one on top of the other according to
a damage mask. The damage mask is sampled in screen space, and is intended to be
rendered to a ViewportTexture from a SubViewport containing some kind of visual
data about the damage to the scene
*/

uniform vec2 scale = vec2(1.0f);
uniform vec2 offset = vec2(0.0f);


uniform sampler2D texUndamaged;
uniform sampler2D texDamaged;
uniform sampler2D damageMask;
//the color channel to sample from the damage mask, default 0 (red)
uniform int channel: hint_range(0, 3, 1) = 0;

//blends the amount by which the damage mask can reveal texDamaged
//at 0, texUndamaged appears everywhere regardless of the mask, and at 1,
//the mask is at its full strength
uniform float influence: hint_range(0.f, 1.f) = 1.f;

void fragment() {
	vec2 transformed_uv = UV * scale + offset;
	transformed_uv = mod(transformed_uv, vec2(1.f));
	
	float maskValue = texture(damageMask, SCREEN_UV)[channel];

	//define weights for how prevalend the undamaged and damaged textures should be
	float weightDamaged = maskValue * influence;
	float weightUndamaged = 1.f - weightDamaged;

	//then sample the textures and scale the samples by their respective weights
	vec4 sampleUndamaged = texture(texUndamaged, transformed_uv) * weightUndamaged;
	vec4 sampleDamaged = texture(texDamaged, transformed_uv) * weightDamaged;

	//as long as the weights always add to about 1, the resulting COLOR will
	//be a nice blend depending on the damageMask
	COLOR = sampleUndamaged + sampleDamaged;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
