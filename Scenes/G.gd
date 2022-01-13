extends Node

var zoom_lv : String = '100'
var zoom_able : bool # Useless for the moment

var stored_img_x : String = ''
var stored_img_y : String = ''

#---------------------layers-------------------------
var selected_layer : int # It seems there is some issue with it [the focus] goes away when you enable themeing.

#----------------- cross profiles ------------------
# [cross] i.e. brush, pencil, pen

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

#Make a seperate reinitializer for sizeing...
#	Add match statements to branch code.
	if size != brush.get_size().x:
		brush.resize(size, size, 4)
		brush_rect = brush.get_used_rect()
		eraser.create(size, size, false, Image.FORMAT_RGBA8)
		blit_brush.resize(size, size, 4)
