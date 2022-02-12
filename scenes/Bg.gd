extends ColorRect

onready var VIEW : Viewport = $".."

func _ready() -> void:
	update_rect()
	_selected_shader(0)

func update_rect() -> void:
	rect_size = VIEW.get_size()

const shader1 := preload("res://assets/shaders/Checker.gdshader")
const shader2 := preload("res://assets/shaders/Dots.gdshader")
const shader3 := preload("res://assets/shaders/Lines.gdshader")
const shader4 := preload("res://assets/shaders/Texture.gdshader")
const shader5 := preload("res://assets/shaders/Transparent.gdshader")

func _selected_shader(index: int) -> void:
	match index:
		0:
			self.material.shader = shader1
		1:
			self.material.shader = shader2
		2:
			self.material.shader = shader3
		3:
			self.material.shader = shader4
		4:
			self.material.shader = shader5
	
