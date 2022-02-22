extends TextureButton

signal attach_leaf

const LEAF := preload("res://scenes/leaf/Leaf.tscn")

func _on_LeafTex_pressed() -> void:
#	print_debug("LeafTex Pressed")
	var a_leaf := LEAF.instance()
	a_leaf.texture = texture_normal
	emit_signal("attach_leaf", a_leaf)

# This is the input area.. this is where you will drag and drop from.
# This will also create the actual textureRects: Named 
# "leaf" 
# that will hold the pics
# inside the canvas.






