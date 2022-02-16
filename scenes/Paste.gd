extends TextureButton

onready var VIEW_PORT := $"../../../System/ViewContainer/Viewport"

const pic := preload("res://assets/library/stickers/1441A0E1-C89F-42FC-8EE0-5476F19F907E.png")
const leaf := preload("res://scenes/leaf/Leaf1.tscn")

func _on_Paste_pressed() -> void:
	print("Profile: Paste Tool selected")
	var a_leaf = leaf.instance()
	a_leaf.texture = pic
	VIEW_PORT.add_child(a_leaf, true)
	
	

#	GET THE PICTURE
#	LISTEN FOR THE NEXT INPUT LOCATION
#	IF THE LOCATION IS INSIDE THE PAGE
#	ADD A NEW ITEM [ A NEW SCREEN ] IF THE ITEM IS INSIDE THE PAGE ELSE CUTOUT THE EXCESIVE.
#	^^^^ BECAREFUL
#	THEN STOP THE INPUT OF THE "LIBRARY ITEM"
#	UNLESS IT HAS BEEN SELECTED FROM THE PASTE BUTTON [AS IN WHEN THE PASTE BUTTON IS IN WORK]
#	THEN THE ITEM HAS BEEN SELECTED WILL BE ONE WITH THE INPUT ON.
