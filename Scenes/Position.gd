extends Label

onready var Screen : Node2D = $"../../../System/ViewContainer/Viewport/Screen"

func _input(_event: InputEvent) -> void:
	if _event is InputEventMouse:
		text = str(Screen.get_local_mouse_position().round()) 

