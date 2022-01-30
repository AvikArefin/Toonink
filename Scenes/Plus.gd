extends VBoxContainer

const _cross : PackedScene = preload("res://Scenes/NewCross/cross.tscn")

func _on_Plus_pressed() -> void:
	var x := _cross.instance()
	
	x.size = G.size
	x.color = G.cross_color
	x.opacity = G.opacity
	x.mode = G.mode
	x.brush = G.brush
	add_child(x, true)
	update()
	queue_sort()




	
