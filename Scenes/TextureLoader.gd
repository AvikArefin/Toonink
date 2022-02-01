extends ItemList

const _BRUSH_DIR := 'res://assets/brushes/'

func _ready() -> void:
	load_brushes()
	
	G.brush = G.brush_list[0] #	could cause problem...
	G.brush_rect = G.brush.get_used_rect()
	
	G.eraser.create(G.brush.get_width(), G.brush.get_height(), true, Image.FORMAT_RGBA8)
	G.blit_brush.copy_from(G.brush_list[0])
	G.blit_brush.fill(Color(G.cross_color))
	G.reinitialize()


func load_brushes() -> void:
	var dir := Directory.new()
	if dir.open(_BRUSH_DIR) == OK:
		var _err = dir.list_dir_begin(true, true) # skips folders, skipes hidden files
		var file_name : String = dir.get_next()
		while file_name != "":
			if !file_name.ends_with('.import'):
				_loader(file_name.get_basename())
#				print("Found file: " + file_name)
			file_name = dir.get_next()
		dir.list_dir_end()

	else:
		print("An error occurred when trying to access the brushes texture folder.")

func _loader(_name_of_brush: String):
	var _brush_path := _BRUSH_DIR + _name_of_brush + '.png'
	var _img := load(_brush_path) as Image
	var _img_tex := ImageTexture.new()
	_img_tex.create_from_image(_img, 0)
	add_item(_name_of_brush, _img_tex, true)
#	Add the brush texture as an image of RGBAF to the global brush_list
#	then select the first as the current brush
	_img.convert(Image.FORMAT_RGBA8) #WTF
	G.brush_list.append(_img)
	
# load is being deprecated in 4.0? what should i use then?


func change_brush(index: int) -> void:
	G.change_brush(index)
