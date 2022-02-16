extends Node

const TEST_POPUP_AREA := Vector2(500, 300)

var zoom_able : bool = true

var stored_img_x : int = 1322
var stored_img_y : int = 753

#---------------------layers-------------------------
var selected_layer : int # It seems there is some issue with it [the focus] goes away when you enable themeing.

#----------------- [cross] profiles ------------------
# ^.^ brush, pencil, pen

var size : int = 16
var cross_color := Color.black
var bg_color := Color.black
var opacity : int = 100 # TODO

#-------------- brushes and brush rects ---------------------
onready var brush_list = []
onready var brush_no : int

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
var current_mode : GDScript = xBlend_Brush

class xBlend_Brush:
	static func draw(img_storage : Image, pos: Vector2) -> void:
		img_storage.blend_rect(G.brush, G.brush_rect, pos - G.brush_dis)
		
class xEraser:
	static func draw(img_storage: Image, pos: Vector2) -> void:
		img_storage.blit_rect_mask(G.eraser, G.brush, G.brush_rect, pos - G.brush_dis)

class xPixel:
	static func draw(img_storage: Image, pos: Vector2) -> void:
		img_storage.set_pixelv(pos, G.cross_color)

class xBlit_Brush:
	static func draw(img_storage: Image, pos: Vector2) -> void:
		img_storage.blit_rect_mask(G.blit_brush, G.brush, G.brush_rect, pos - G.brush_dis)

var MODES := {
	0 : xBlend_Brush,
	1 : xEraser,
	2 : xPixel,
	3 : xBlit_Brush
}

func change_mode(index: int) -> void:
	mode_no = index
	current_mode = MODES[index]
	reinitialize()

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
#---------------------------------- Text file type ----------------------------
var text_file_type : String = '.txt'
