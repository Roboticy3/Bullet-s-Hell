extends CanvasLayer

### Contain the damage model for obstacles
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
	#Instead, we connect a signal that should be fired whenever an obstacle view
	#calls its _ready method, passing itself as a reference.
	#Then, give_damage_model attempts to pass the damage model to the obstacle
	#view's instance of the shader.
	Accessor.obstacle_view_added.connect(give_damage_model)
	
	#the subviewport, if the right flag is checked, should always draw 
	#its contents, whether it is visible or not. 
	#However, this doesn't seem to be working. >:(
	#Since the damage model is alpha-based, and contains nothing 
	#when the game starts, we can afford to have it visible for a second, then
	#hide it, which kicks it into gear for some reason.
	visible = true
	get_tree().create_timer(1.0).timeout.connect(func ():
		visible = false
	)
	
	#print("trying to get texture from subviewport ", subviewport)
	if (subviewport is SubViewport):
		damage_model = subviewport.get_texture()

func give_damage_model(obstacle_view:CanvasItem):
	#print("revieved material ", obstacle_view.material, " through obstacle_view_added")
	if !(obstacle_view.material is ShaderMaterial) || damage_model == null: return
	var material:ShaderMaterial = obstacle_view.material
	
	material.set_shader_parameter("damageMask", damage_model)
	
	#print("gave obstacle view ", obstacle_view, " damage model ", damage_model)
