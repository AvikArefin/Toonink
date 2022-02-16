extends TextureRect

func _input(_event: InputEvent) -> void:
	rect_position = get_global_mouse_position()
	
	if Input.is_action_pressed("primary"):
		print("made false")
		set_process_input(false)
