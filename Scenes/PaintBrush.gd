extends TextureButton

onready var SCREEN:= $"../../../System/ViewContainer/Viewport/Screen"
onready var TEXTPORT := $"../../../System/ViewContainer/Viewport/TextPort"

func _on_PaintBrush_pressed() -> void:
	print("Profile: Paint Brush")
	G.size  = 16
	G.cross_color = Color.red 
	G.opacity = 100
	G.current_mode = G.MODES[0]
	G.brush = G.brush_list[7]
	G.reinitialize()

	SCREEN.is_allowed = true
	
	G.zoom_able = true
#	TEXTPORT.mouse_filter = Control.MOUSE_FILTER_IGNORE
	TEXTPORT.set_process_input(false) # <- possiably the better way to do this
	
	
#	TEXTPORT.mouse_default_cursor_shape = Control.CURSOR_CROSS
#   The above lines doesn't actually work as the input for text for is now beign ignored.
#	The above lines are causeing trouble.
