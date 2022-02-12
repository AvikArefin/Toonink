extends VBoxContainer

const _BRUSH_DIR := 'res://assets/brushes/'
const _brush_texture := preload("res://scenes/NewBrush/_brush.tscn")

func _ready() -> void:
	load_brushes()
	
	G.brush_no = 0
	G.brush = G.brush_list[G.brush_no] #	could cause problem...
	G.brush_rect = G.brush.get_used_rect()
	
	G.eraser.create(G.brush.get_width(), G.brush.get_height(), true, Image.FORMAT_RGBA8)
	G.blit_brush.copy_from(G.brush_list[G.brush_no])
	G.blit_brush.fill(Color(G.cross_color))
	G.reinitialize()


func load_brushes() -> void:
	var dir := Directory.new()
	if dir.open(_BRUSH_DIR) == OK:
		var _err = dir.list_dir_begin(true, true) # skips folders, skipes hidden files
		var file_name : String = dir.get_next()
		var count : int = 0
		while file_name != "":
			if !file_name.ends_with('.import'):
				_loader(file_name.get_basename(), count)
				count = count +1
#				print("Found file: " + file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
		count = 0

	else:
		print("An error occurred when trying to access the brushes texture folder.")

func _loader(_name_of_brush: String, brush_number : int):
	var _brush_path := _BRUSH_DIR + _name_of_brush + '.png'
	var _img := load(_brush_path) as Image
	
#	Add the brush texture as an image of RGBAF to the global brush_list
#	then select the first as the current brush
	_img.convert(Image.FORMAT_RGBA8) #WTF
	G.brush_list.append(_img)
	
	var i : Image = Image.new()
	i.copy_from(_img)
	
	i.resize(32, 32, Image.INTERPOLATE_NEAREST) #WTF #DELETE #FIXIT
	var _img_tex := ImageTexture.new()
	_img_tex.create_from_image(i, 0)

	var brush_texture_spawn = _brush_texture.instance()
	brush_texture_spawn.texture_normal = _img_tex
	brush_texture_spawn.no = brush_number
	add_child(brush_texture_spawn)
	
# load is being deprecated in 4.0? what should i use then?

