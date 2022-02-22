extends TextureButton

onready var SCREEN := $"../../../System/ViewContainer/Viewport/Screen"
onready var TEXTPORT := $"../../../System/ViewContainer/Viewport/TextPort"
onready var VIEW := $"../../../System/ViewContainer/Viewport/view"

func _on_Eraser_pressed() -> void:
	print_debug("profile: Eraser")
	G.size = 16
	G.cross_color = Color.red 
	G.opacity = 100
	G.current_mode = G.MODES[1]
	G.brush = G.brush_list[5]
	G.reinitialize()

	G.zoom_able = true

	TEXTPORT.mouse_filter = Control.MOUSE_FILTER_IGNORE
	SCREEN.mouse_filter = Control.MOUSE_FILTER_STOP #[otherwise the mouse would flicker when changing from the texttool to erasertool]
	SCREEN.set_process_input(true)
