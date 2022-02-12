extends Node

const TEST_POPUP_AREA := Vector2(500, 300)
onready var window_size_x : int = int(OS.get_window_safe_area().size.x)
onready var window_size_y : int = int(OS.get_window_safe_area().size.y)

func refresh_window_size() -> void:
	window_size_x = int(OS.get_window_safe_area().size.x)
	window_size_y = int(OS.get_window_safe_area().size.y)


var zoom_able : bool = true

var stored_img_x : int
var stored_img_y : int

#---------------------layers-------------------------
var selected_layer : int # It seems there is some issue with it [the focus] goes away when you enable themeing.

#----------------- [cross] profiles ------------------
# ^.^ brush, pencil, pen

var size : int = 16
var cross_color := Color.black
var bg_color := Color.black
var opacity : int = 100 # TODO

#-------------- brushes and brush rects ---------------------
var brush_list = []
var brush_no : int

var brush := Image.new()
var eraser := Image.new()
var blit_brush := Image.new()
var brush_rect : Rect2 

var brush_dis : Vector2
#----------------change brush-------------------------------------------

func change_brush(index: int) -> void:
	brush_no = index
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
#		print(size)
#		print(brush.get_size())
		brush.copy_from(brush_list[brush_no])
		brush.resize(size, size, Image.INTERPOLATE_NEAREST)
		
		brush_rect = Rect2(Vector2.ZERO, Vector2(brush.get_size().x, brush.get_size().y))
#		brush_rect = brush.get_used_rect()
		eraser.create(size, size, false, Image.FORMAT_RGBA8)
		blit_brush.resize(size, size, Image.INTERPOLATE_NEAREST)

#	Readjust the brush center displacement
	var w : float = brush.get_width() / 2.0
	var h : float = brush.get_height() / 2.0
	brush_dis = Vector2(w , h)
