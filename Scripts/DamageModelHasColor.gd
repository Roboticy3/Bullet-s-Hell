extends CanvasLayer
class_name TextureHasColor

@export_node_path("SubViewport") var subviewport_path:NodePath
@onready var subviewport:SubViewport = get_node_or_null(subviewport_path)

@export_node_path("TextureRect") var rect_path:NodePath
@onready var rect:TextureRect = get_node_or_null(rect_path)

@export var on_process := true

var last_call := false

func _ready():
	set_process(on_process)

func _process(delta: float) -> void:
	last_call = has_color(null)

func has_color(tex) -> bool:
	var downscaled_tex := ViewportTexture.new()
	downscaled_tex.viewport_path = subviewport_path
	
	if tex is Texture2D: rect.texture = tex
	
	var result_image = subviewport.get_texture().get_image()
	
	var sum := 0.0
	for y in range(0, result_image.get_height(), 8):
		for x in range(0, result_image.get_width(), 8):
			sum += result_image.get_pixel(x, y).a
	if sum >= 0.5: print("found sum of ", sum)
	return sum >= 0.5
