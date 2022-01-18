extends Node

onready var window_size_x : int = OS.get_window_safe_area().size.x
onready var window_size_y : int = OS.get_window_safe_area().size.y

var zoom_lv : String = '100'
var zoom_able : bool = true

var stored_img_x : String = ''
var stored_img_y : String = ''

#---------------------layers-------------------------
var selected_layer : int # It seems there is some issue with it [the focus] goes away when you enable themeing.

#----------------- [cross] profiles ------------------
# ^.^ brush, pencil, pen

var size : int = 16
var cross_color := Color.red 
var opacity : int = 100
var mode : int
var tex_img : Image

#-------------- brushes and brush rects ---------------------
var brush_list = []

var brush := Image.new()
var eraser := Image.new()
var blit_brush := Image.new()
var brush_rect : Rect2 

export(Vector2) var brush_dis : Vector2

var w : float
var h : float

#----------------Initailizer---------------------------------------
func reinitialize() -> void:
	match mode:
		2:
			eraser.create(brush.get_width(), brush.get_height(), false, Image.FORMAT_RGBA8)
		4:
			blit_brush.create(brush.get_width(), brush.get_height(), false, Image.FORMAT_RGBA8)
			blit_brush.fill(Color(cross_color))
		_:
			pass

#	Add match statements to branch code.
	if size != brush.get_size().x:

		brush.resize(size, size, Image.INTERPOLATE_LANCZOS)
		brush_rect = brush.get_used_rect()
		eraser.create(size, size, false, Image.FORMAT_RGBA8)
		blit_brush.resize(size, size, Image.INTERPOLATE_LANCZOS)

	w = brush.get_width() / 2.0
	h = brush.get_height() / 2.0
	brush_dis = Vector2(w , h)

# Fix the issue where the texture changes when the brush is resized...

#Make a seperate reinitializer for sizeing...

