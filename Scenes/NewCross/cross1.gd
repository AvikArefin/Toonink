extends TextureButton

var size : int
var color : Color
var opacity : int
var mode_no : int
var brush : Image
#no need to store brush_rect

	
func _on_cross1_pressed() -> void:
	G.size = size
	G.cross_color = color
	G.opacity = opacity
	G.change_mode(mode_no)
	
	G.brush = brush
	G.brush_rect = brush.get_used_rect()
	
	G.reinitialize()
	


