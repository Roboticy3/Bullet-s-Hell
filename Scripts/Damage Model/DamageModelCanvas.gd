extends CanvasLayer

### Pass the damage model for obstacles to the Accessor
#So what's all this fuss about a damage model anyways?
#The damage model is a texture that can be used to show obstacles in a damaged
#state. This is desirable because we can show the player's path of destruction.

#To render the "damage model", we have the player leave some sort of trail under
#a subviewport, which will be invisible to the player, but will still be
#rendered internally.
#Then, the shader Shaders/DamageTexture.gdshader superimposes that texture over
#the shapes drawing the obstacles (called obstacle views), which shows "damage",
#usually a darker version of the "undamaged" texture.

@export_node_path("SubViewport") var subviewport_path := NodePath(
	"SubViewportContainer/SubViewport"
)
@onready var subviewport = get_node_or_null(subviewport_path)

var damage_model:ViewportTexture

func _ready() -> void:
	
	#Viewport textures can't exist as files, they must be attached to a scene.
	#For this reason, materials using DamageTexture can't have the damage model 
	#applied by default (to my knowledge).
	
	#Since a lot of objects access the same damage model, and there should only
	#really be one on screen at the same time, we feed it through the accessor
	
	#print("trying to get texture from subviewport ", subviewport)
	if (subviewport is SubViewport):
		Accessor.damage_model_viewport = subviewport
		#print("set damage_model_viewport to ", subviewport)

func give_damage_model(obstacle_view:CanvasItem):
	#print("revieved material ", obstacle_view.material, " through obstacle_view_added")
	if !(obstacle_view.material is ShaderMaterial) || damage_model == null: return
	var material:ShaderMaterial = obstacle_view.material
	
	material.set_shader_parameter("damageMask", damage_model)
	
	#print("gave obstacle view ", obstacle_view, " damage model ", damage_model)
