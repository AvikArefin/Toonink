extends TextEdit

func _ready():
	add_color_override("font_color", G.cross_color)
	# just pass for now in 4.0
	#	TODO: add settings to ensure that textport supports dark mode
