extends TextureRect

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
			if Input.is_action_pressed("primary"):
				rect_position = get_global_mouse_position()
				#print_debug("hello from leaf")

	elif event.is_action_pressed("not"):
		print_debug("made false")
		set_process_input(false)
		self.set_script(null)
