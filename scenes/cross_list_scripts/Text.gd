extends TextureButton

onready var SCREEN := $"../../../System/ViewContainer/Viewport/Screen" #as Node2D
onready var TEXTPORT := $"../../../System/ViewContainer/Viewport/TextPort" as TextEdit

func _on_Text_pressed() -> void:
		
	print_debug("profile: text")

	G.zoom_able = true
	
	TEXTPORT.mouse_filter = Control.MOUSE_FILTER_STOP # not a must
#	TEXTPORT.mouse_default_cursor_shape = Control.CURSOR_IBEAM
	SCREEN.mouse_filter = Control.MOUSE_FILTER_IGNORE # the input will be handed over to textport without being processed
	SCREEN.set_process_input(false) # to make sure the "_input()" function doesn't receive anything.
	
	
	
	
	
