extends Camera2D

onready var Screen : Node2D = $"../Screen"

var zoom_min := Vector2(0.005, 0.005)
var zoom_max := Vector2.ONE

func _input(event) -> void:
	if Screen.is_allowed:
		if event.is_action_pressed("zoom_in"): # Wheel Up Event
			zoom_camera(-1)
		elif event.is_action_pressed("zoom_out"): # Wheel Down Event
			zoom_camera(1)

# Zoom Camera
func zoom_camera(dir : int) -> void:
	var zoom_margin = zoom * dir / 10
	#if zoom + zoom_margin > zoom_min && zoom + zoom_margin < zoom_max:
	if zoom + zoom_margin > zoom_min:
		zoom += zoom_margin
	
	if zoom > zoom_max:
		zoom = zoom_max
	
	G.zoom_lv = "x%s" % [stepify(1 / zoom.x, 0.01)]

