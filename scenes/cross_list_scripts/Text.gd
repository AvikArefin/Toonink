extends TextureButton

onready var SCREEN := $"../../../System/ViewContainer/Viewport/Screen" #as Node2D
onready var TEXTPORT := $"../../../System/ViewContainer/Viewport/TextPort" as TextEdit

func _on_Text_pressed() -> void:
	print("profile: text")
	
	SCREEN.is_allowed = false
	
	
	G.zoom_able = true
	TEXTPORT.mouse_filter = Control.MOUSE_FILTER_STOP
	TEXTPORT.mouse_default_cursor_shape = Control.CURSOR_IBEAM
