extends VBoxContainer

const _CROSS : PackedScene = preload("res://Scenes/NewCross/cross.tscn")

func _on_Plus_pressed() -> void:
	var x := _CROSS.instance()
	
	x.size = G.size
	x.color = G.cross_color
	x.opacity = G.opacity
	x.mode_no = G.mode_no

	x.brush = G.brush
	add_child(x, true)
	update()
	queue_sort()




	
