extends SpinBox

func _on_size_value_changed(value: float) -> void:
	G.size = int(value)
	G.reinitialize()
#	print_debug(is_allowed)

#	Fix the size issue of the textures.
