extends TextureButton

var no : int
func _on_brush_pressed() -> void:
	print("yes")
	G.change_brush(no)
	
#This might not be needed anymore as texturebuttons contain the texture
# themselves.
