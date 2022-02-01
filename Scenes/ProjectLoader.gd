extends FileDialog

const TEST := Vector2(500, 300)
onready var SCREEN : Node2D = $"../../System/ViewContainer/Viewport/Screen"
onready var VIEW : Camera2D = $"../../System/ViewContainer/Viewport/view"

func _projectloader(index : int) -> void:
	G.zoom_able = false
	SCREEN.is_allowed = false
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
#		img.create(G.window_size_x, G.window_size_y, true, 0)
#		img.create(G.window_size_x, G.window_size_y, true, 0)
		
#		SCREEN.img_storage = img
		
		SCREEN.img_storage = Image.new()
		SCREEN.img_storage.load(path)
		SCREEN.img_storage.convert(Image.FORMAT_RGBA8)
		
		SCREEN.img_storage.lock()
		SCREEN.update()
		
		G.stored_img_x = str(SCREEN.img_storage.get_size().x)
		G.stored_img_y = str(SCREEN.img_storage.get_size().y)
		
		VIEW.reset_zoom()

func save_confirmed() -> void:
	if mode == MODE_SAVE_FILE:
		SCREEN.img_storage.save_png(current_path)

func cross_allowed() -> void:
	SCREEN.is_allowed = true
	G.zoom_able = true
