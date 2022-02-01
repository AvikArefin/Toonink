extends TextureButton


#Signal the change of mode... and receive the signal in the $Screen
#on in the function change mode.
var size : int
var color : Color
var opacity : int
var mode_no : int
var brush : Image
#no need for brush_rect


func _on_cross1_pressed() -> void:
	G.size = size
	G.cross_color = color
	G.opacity = opacity
#	G.mode_no = mode_no
	
	G.brush = brush
	G.brush_rect = brush.get_used_rect()
	G.change_mode(mode_no)
#	G.reinitialize()
	prints(size, color, opacity, mode_no)
	prints(G.size, G.cross_color, G.opacity, G.mode_no)
#	both of them are same it means that means the value of them are changing
#	but somehow neither of them are being used.
	

#	G.current_mode = G.MODES[1]
#	G.brush = G.brush_list[5]
#	G.reinitialize()

	
