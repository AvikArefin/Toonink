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

#-------------- brushes and brush rects ---------------------
var brush_list = []

var brush := Image.new()
var eraser := Image.new()
var blit_brush := Image.new()
var brush_rect : Rect2 

var brush_dis : Vector2
#----------------change brush-------------------------------------------

func change_brush(index: int) -> void:
	brush = brush_list[index] 
	brush_rect = brush.get_used_rect() 
	
	reinitialize()
#-------------------mode changer-------------------------
var mode_no : int
var current_mode : GDScript = Blend_Brush

enum Modes { BRUSH = 0, ERASER = 1, PIXEL = 2, BLIT_BRUSH = 3}
const MODES = {
	Modes.BRUSH : Blend_Brush,
	Modes.ERASER : Eraser,
	Modes.PIXEL : Pixel,
	Modes.BLIT_BRUSH : Blit_Brush
}

func change_mode(index: int) -> void:
	G.mode_no = index
	current_mode = MODES[index]
	G.reinitialize()

#----------------Initailizer---------------------------------------
func reinitialize() -> void:
	match mode_no:
		2:
			eraser.create(brush.get_width(), brush.get_height(), false, Image.FORMAT_RGBA8)
		4:
			blit_brush.create(brush.get_width(), brush.get_height(), false, Image.FORMAT_RGBA8)
			blit_brush.fill(Color(cross_color))
		_:
			pass

#	Checkes if the size is okay.
	if size != brush.get_size().x:
		brush.resize(size, size, 3)
		brush_rect = brush.get_used_rect()
		eraser.create(size, size, false, Image.FORMAT_RGBA8)
		blit_brush.resize(size, size, 3)

#	Readjust the brush center displacement
	var w : float = brush.get_width() / 2.0
	var h : float = brush.get_height() / 2.0
	brush_dis = Vector2(w , h)

# Fix the issue where the texture changes when the brush is resized...
