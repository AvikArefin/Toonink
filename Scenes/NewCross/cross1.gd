extends TextureButton

#Signal the change of mode... and receive the signal in the $Screen
#on in the function change mode.
var size : int
var color : Color
var opacity : int
var mode : int
var brush : Image
#no need for brush_rect


func _on_cross1_pressed() -> void:
	G.size = size
	G.cross_color = color
	G.opacity = opacity
	G.mode = mode
	G.brush = brush
	G.brush_rect = brush.get_used_rect()

	G.reinitialize()
	prints(size, color, opacity, mode)
	prints(G.size, G.cross_color, G.opacity, G.mode)
#	both of them are same it means that means the value of them are changing
#	but somehow neither of them are being used.
	


	
