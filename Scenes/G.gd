extends Node

var zoom_lv : String = '100'
var zoom_able : bool # Useless for the moment

var cross_color := Color.red 
var cross_color_2 := Color.yellow
#const cross_color_3 := Color.darkviolet

var stored_img_x : String = ''
var stored_img_y : String = ''

var brush_list = []

var brush := Image.new()
var eraser := Image.new()
var blit_brush := Image.new() # Work on this...
var brush_rect : Rect2 

var selected_layer : int

var mode : int
var size : int = 16


