extends Camera2D

onready var Screen : Node2D = $".."

var mouse_position : Vector2
var zoom_step : float = 1.1

func _input(event: InputEvent) -> void:
#	print('yes')
	if Screen.is_allowed == true:
		if event is InputEventMouse:
			if event.is_pressed() and not event.is_echo():
				mouse_position = event.position
				if event.button_index == BUTTON_WHEEL_DOWN:
					zoom_at_point(zoom_step, mouse_position)
				else :
					if event.button_index == BUTTON_WHEEL_UP:
						zoom_at_point(1/zoom_step, mouse_position)

func zoom_at_point(zoom_change, point) -> void:
	var c0 := global_position # camera position
	var v0 := get_viewport().size # vieport size
	var c1 : Vector2# next camera position
	var z0 := zoom # current zoom value
	var z1 = z0 * zoom_change # next zoom value

	c1 = c0 + (-0.5*v0 + point)*(z0 - z1)
	zoom = z1
	
	global_position = c1
	
