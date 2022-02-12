extends TextureButton

func _on_Eraser_pressed() -> void:
	print("profile: Eraser")
	G.size  = 16
	G.cross_color = Color.red 
	G.opacity  = 100
	G.current_mode = G.MODES[1]
	G.brush = G.brush_list[5]
	G.reinitialize()



