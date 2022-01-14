extends VBoxContainer

const _cross : PackedScene = preload("res://Scenes/cross.tscn")

func _on_Plus_pressed() -> void:
	var x = _cross.instance()
#	x.rect_position = Vector2(8, 104)
		
	x.size = G.size
	x.color = G.cross_color
	x.opacity = G.opacity
	x.mode = G.mode
	x.brush = G.brush
	add_child(x, true)
	update()
	queue_sort()




	