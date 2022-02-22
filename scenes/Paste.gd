extends TextureButton

onready var SCREEN:= $"../../../System/ViewContainer/Viewport/Screen"
onready var VIEW_PORT := $"../../../System/ViewContainer/Viewport"
onready var LAYERS := $"../../Layers"


func _on_Paste_pressed() -> void:
	print_debug("Profile: Paste Tool selected")

	LAYERS._refresh()
	SCREEN.set_process_input(false)

	G.zoom_able = true
	
