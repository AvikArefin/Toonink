extends FileDialog

onready var SCREEN := $"../../System/ViewContainer/Viewport/Screen" #as Node2D
onready var VIEW := $"../../System/ViewContainer/Viewport/view" as Camera2D
onready var TEXTPORT := $"../../System/ViewContainer/Viewport/TextPort" as TextEdit
onready var RESOLUTION := $"../Bar/ResTag" as Label

func _projectloader(index : int) -> void:
	match index:
		0:
			get_line_edit().visible = false
			set_mode(FileDialog.MODE_OPEN_FILE)
		1:
			get_line_edit().visible = true
			set_mode(FileDialog.MODE_SAVE_FILE) ####
#	popup_centered(G.TEST_POPUP_AREA)
	popup()


func _on_ProjectLoader_file_selected(path: String) -> void:
	if mode == MODE_OPEN_FILE:
		SCREEN.img_storage = Image.new()
		SCREEN.img_storage.load(path)
		SCREEN.img_storage.convert(Image.FORMAT_RGBA8)
		SCREEN.img_storage.lock() # 4.0 deprecated
		SCREEN.update()
#		Recalculate the screen rect, based on the loaded pic, that is being used as a boundry for the input i.e. cross to draw in.
		G.stored_img_x = SCREEN.img_storage.get_size().x
		G.stored_img_y = SCREEN.img_storage.get_size().y
		SCREEN.update_screen_rect()
		RESOLUTION.update_info()

		VIEW.reset_zoom()
		
#		support for text
		var file := File.new()
		var new_file_path : String = current_path.trim_suffix('.' + current_path.get_extension()) + G.text_file_type
#		TODO do something about this line above..
		if file.file_exists(new_file_path): # need to work on the variable
			var _err = file.open(new_file_path, File.READ)
			TEXTPORT.text = file.get_as_text()
			file.close()

func save_confirmed() -> void:
	if mode == MODE_SAVE_FILE:
		SCREEN.img_storage.save_png(current_path)

		var text_content : String = TEXTPORT.text
		var file := File.new()
		var new_file_path : String = current_path.trim_suffix('.' + current_path.get_extension()) + '.txt'
		var _err := file.open(new_file_path, File.WRITE)
		file.store_string(text_content)
		file.close()

# TODO: make sure that the texts are saved as txt files (with markdown and/ or bbcode) support
# TODO: Offer to integrating the texts as part of the "drawing"

