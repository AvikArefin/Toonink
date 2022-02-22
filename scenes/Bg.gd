extends ColorRect

func _ready() -> void:
	_change_shader(6)

func update_rect() -> void:
	rect_size = Vector2(G.stored_img_x, G.stored_img_y)


const shader0 := preload("res://assets/shaders/Checker.gdshader")
const shader1 := preload("res://assets/shaders/Dots.gdshader")
const shader2 := preload("res://assets/shaders/Lines.gdshader")
const shader3 := preload("res://assets/shaders/Solid.gdshader")
const shader4 := preload("res://assets/shaders/Texture.gdshader")
const shader5 := preload("res://assets/shaders/Transparent.gdshader")

func _change_shader(index: int) -> void:
	var _color_rgb := Vector3(G.bg_color.r, G.bg_color.g, G.bg_color.b)
	match index:
		0:
			self.material.shader = shader0
			self.material.set_shader_param("line_color", G.bg_color)
		1:
			self.material.shader = shader1
			self.material.set_shader_param("color_rgb", _color_rgb)
		2:
			self.material.shader = shader2
			self.material.set_shader_param("line_color", G.bg_color)
		3:
			self.material.shader = shader3
			self.material.set_shader_param("_color", G.bg_color)
		4:
			self.material.shader = shader4
		5:
			self.material.shader = shader5
		6:
			self.material.shader = null
