extends FileDialog

const TEST := Vector2(500, 300)
onready var Screen : Node2D = $"../../System/ViewContainer/Viewport/Screen"

func _projectloader(index : int) -> void:
	G.zoom_able = false
	Screen.is_allowed = false
	match index:
		0:
			get_line_edit().visible = false
			set_mode(FileDialog.MODE_OPEN_FILE)
		1:
			get_line_edit().visible = true
			set_mode(FileDialog.MODE_SAVE_FILE) ####
	popup_centered(TEST)


func _on_ProjectLoader_file_selected(path: String) -> void:
	if mode == MODE_OPEN_FILE:
#		var img := Image.new()
#		img.create(G.window_size_x, G.window_size_y, true, Image.FORMAT_RGBA8)
#		img.create(G.window_size_x, G.window_size_y, true, Image.FORMAT_RGBA8)
		
#		Screen.img_storage = img
		
		Screen.img_storage = Image.new()
		Screen.img_storage.load(path)
		Screen.img_storage.convert(Image.FORMAT_RGBA8)
		
		Screen.img_storage.lock()
		Screen.update()
		
		G.stored_img_x = str(Screen.img_storage.get_size().x)
		G.stored_img_y = str(Screen.img_storage.get_size().y)


func save_confirmed() -> void:
	if mode == MODE_SAVE_FILE:
		Screen.img_storage.save_png(current_path)

func cross_allowed() -> void:
	Screen.is_allowed = true
