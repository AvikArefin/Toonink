extends Camera2D

const zoom_max := 4.0
const zoom_min := 0.05

var zoom_step := 1.1
var zoom_x : float

onready var ZOOM_LV := $"../../../../UI/Bar/Zoom_lv"

func _input(event) -> void:
	if G.zoom_able:
		if event is InputEventMouse:
			if event.is_pressed() and not event.is_echo():
				var mouse_position = event.position
				if event.button_index == BUTTON_WHEEL_DOWN:
					zoom_at_point(zoom_step, mouse_position)
				else :
					if event.button_index == BUTTON_WHEEL_UP:
						zoom_at_point(1/zoom_step, mouse_position)

func zoom_at_point(zoom_change, point) -> void:
	var c0 = global_position # camera position
	var v0 = get_viewport().size # vieport size
	var c1 # next camera position
	var z0 = zoom # current zoom value
	var z1 = z0 * zoom_change # next zoom value

	c1 = c0 + (-0.5*v0 + point)*(z0 - z1)
	
#	actually zoom...
	zoom_x = z1.x
	if zoom_x < zoom_max and zoom_x > zoom_min:
		
		update_transparent_checker_offset()
		zoom = z1
		global_position = c1

		ZOOM_LV.value = 100/zoom_x

func reset_zoom() -> void:
#	print("reset_zoom")
	zoom = Vector2.ONE
	ZOOM_LV.value = 100
	global_position = Vector2.ZERO

func update_transparent_checker_offset() -> void: # update name to bg
#	var o := get_global_transform_with_canvas().get_origin()
#	var s := get_global_transform_with_canvas().get_scale()
#	o.y = get_viewport_rect().size.y - o.y
#	TRANSPARENT_CHECKER.update_offset(o, s)
	pass
# update_transparent_checker_offset() ------> update_bg_offset()


func _on_Zoom_lv_value_changed(value: float) -> void:
	zoom = Vector2(100 / value, 100 /value)
