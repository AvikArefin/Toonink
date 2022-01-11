extends Label

func _ready():
	pass

func _input(_event: InputEvent) -> void:
	text = str(get_local_mouse_position()) + "  - [" + G.stored_img_x + "×" + G.stored_img_y + "] px -  " + G.zoom_lv + "%"  

