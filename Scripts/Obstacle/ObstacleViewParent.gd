extends Node

### View the damage model traced by the player
#By referencing the damage model texture (see
#"Scripts/Damage Model/DamageModelCanvas.gd") and giving that reference to the 
#"damageMask" property of a shader material (usually 
#"Shaders/DamageTexture.gdshader"), an obstacle can show the path taken by the
#player as damage

func _ready():
	#since the accessor stores the damage model, all we have to do is watch for
	#updates.
	Accessor.damage_model_viewport_set.connect(set_damage_models)
	
	#if the damage model is already loaded, update children immediately
	if (Accessor.damage_model_viewport is SubViewport):
		set_damage_models()

#When a new damage model is found, check that the current material is the right
#type to have shader parameters passed.
func set_damage_models():
	#print("reading damage_model_viewport ", Accessor.damage_model_viewport)
	for c in get_children():
		if !(c is CanvasItem): continue #ensure the child has a material
		
		var m = c.material
		#ensure material and damage model have right type
		if (m is ShaderMaterial &&
				Accessor.damage_model_viewport is SubViewport): 
				#then, apply changes to the child
				m.set_shader_parameter(
					"damageMask", 
					Accessor.damage_model_viewport.get_texture()
				)
				#print("set damage model at ", c, " with material ", m, " and texture ", Accessor.damage_model_viewport.get_texture())
