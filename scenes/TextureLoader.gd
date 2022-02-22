extends VBoxContainer

const _BRUSH_DIR := 'res://assets/brushes/'
const _brush_texture : PackedScene = preload("res://scenes/NewBrushTexture/BrushTex.tscn")

func _ready() -> void:
	xload_brushes()
	
	G.brush_no = 0
	G.brush = G.brush_list[0] #	could cause problem... TODO Fix problem...
	G.brush_rect = G.brush.get_used_rect()

	G.eraser.create(G.brush.get_width(), G.brush.get_height(), true, Image.FORMAT_RGBA8)
	G.blit_brush.copy_from(G.brush_list[0])
	G.blit_brush.fill(Color(G.cross_color))
	G.reinitialize()

# load is being deprecated in 4.0? what should i use then?

func xload_brushes() -> void:
	var file_paths : Array = get_file_paths_in_folder(_BRUSH_DIR)
	var counter : int = 0
	for i in file_paths:
		var _img := ResourceLoader.load(i, "", true) as Image
		_img.convert(Image.FORMAT_RGBA8) #WTF
		G.brush_list.append(_img)
		
		var copy : Image = Image.new()
		copy = ResourceLoader.load(i, "", true) as Image
		copy.convert(Image.FORMAT_RGBA8)
#		copy.copy_from(_img)
#		copy.resize(32, 32, Image.INTERPOLATE_NEAREST) #WTF #DELETE #FIXIT
		
		var _img_tex := ImageTexture.new()
		_img_tex.create_from_image(copy, 0)
	
		var brush_texture_spawn := _brush_texture.instance()
		brush_texture_spawn.texture_normal = _img_tex
		brush_texture_spawn.no = counter
		counter += 1
		add_child(brush_texture_spawn)
		

#	A workaround...
func get_file_paths_in_folder(folder_path: String) -> Array:
	
	var file_paths := []
	
	var dir := Directory.new()
	var _err1 = dir.open(folder_path)
	var _err2 = dir.list_dir_begin(true, true) # true, true params to skip hidden and navigational
	
	while true:
		var file := dir.get_next()
		if file == "":
			break
		if !file.ends_with(".import"):
			continue 
		file_paths.append(folder_path + file.replace(".import", ""))

	dir.list_dir_end()
	
	return file_paths
