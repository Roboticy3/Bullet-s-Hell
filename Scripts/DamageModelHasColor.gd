extends CanvasLayer
class_name TextureHasColor

@export_node_path("SubViewport") var subviewport_path:NodePath
@onready var subviewport:SubViewport = get_node_or_null(subviewport_path)

@export_node_path("TextureRect") var rect_path:NodePath
@onready var rect:TextureRect = get_node_or_null(rect_path)

@export var on_process := true

@export var color := Color.BLUE

var last_call := false

func _ready():
	set_process(on_process)

func _process(delta: float) -> void:
	last_call = has_color(null)

func has_color(tex, target_color:=color, tolerance:=0.1) -> bool:
	var downscaled_tex := ViewportTexture.new()
	downscaled_tex.viewport_path = subviewport_path
	
	if tex is Texture2D: rect.texture = tex
	rect.material.set_shader_parameter("target_color", target_color)
	rect.material.set_shader_parameter("tolerance", tolerance)
	
	var result_image = subviewport.get_texture().get_image()
	
	for y in result_image.get_height():
		for x in result_image.get_width():
			if result_image.get_pixel(x, y).a > 0.5:
				return true
	return false
