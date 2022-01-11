extends ItemList

const brushes_dir := 'res://brushes/'

func _ready() -> void:
	load_brushes()
#	could cause problem...
	G.brush = G.brush_list[0]
	G.brush_rect = G.brush.get_used_rect()
	
	G.blit_brush.copy_from(G.brush_list[0])
	G.blit_brush.fill(Color(G.cross_color))


func load_brushes() -> void:
	var dir := Directory.new()
	if dir.open(brushes_dir) == OK:
		var _err = dir.list_dir_begin(true, false) # skips folders, doesn't skip hidden
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
	var _brush_path := brushes_dir + _name_of_brush + '.png'
	var _img := load(_brush_path) as Image
	var _img_tex := ImageTexture.new()
	_img_tex.create_from_image(_img, Image.FORMAT_RGBA8)
	add_item(_name_of_brush, _img_tex, true)
#	Add the brush texture as an image of RGBA8 to the global brush_list
#	then select the first as the current brush
	_img.convert(Image.FORMAT_RGBA8)
	G.brush_list.append(_img)
	
#func choose_brush(index: int) -> void:
#	G.brush = G.brush_list[index]
#	G.brush_rect = G.brush.get_used_rect()
#
#	G.eraser.create(G.brush.get_size().x, G.brush.get_size().y, false, Image.FORMAT_RGBA8)
#	G.blit_brush.create(G.brush.get_size().x, G.brush.get_size().y, false, Image.FORMAT_RGBA8)
#	G.blit_brush.fill(G.cross_color)
#

	
	
