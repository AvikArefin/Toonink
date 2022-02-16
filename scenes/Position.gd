extends Label

onready var SCREEN : = $"../../../System/ViewContainer/Viewport/Screen" 

func _input(_event: InputEvent) -> void:
	if _event is InputEventMouse:
		text = str(SCREEN.get_local_mouse_position().round()) 

