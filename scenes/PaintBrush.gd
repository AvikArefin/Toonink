extends TextureButton

onready var SCREEN:= $"../../../System/ViewContainer/Viewport/Screen"
onready var TEXTPORT := $"../../../System/ViewContainer/Viewport/TextPort"
onready var VIEW := $"../../../System/ViewContainer/Viewport/view"


func _on_PaintBrush_pressed() -> void:
	print_debug("Profile: Paint Brush")
	G.size = 16
	G.cross_color = Color.red
	G.opacity = 100
	G.current_mode = G.MODES[0]
	G.brush = G.brush_list[7]
	G.reinitialize()


	G.zoom_able = true

	TEXTPORT.mouse_filter = Control.MOUSE_FILTER_IGNORE
#	SCREEN.mouse_filter = Control.MOUSE_FILTER_STOP
	SCREEN.set_process_input(true)
	
#	TEXTPORT.mouse_default_cursor_shape = Control.CURSOR_CROSS
#   The above lines doesn't actually work as the input for text for is now beign ignored.
#	The above lines are causeing trouble.
