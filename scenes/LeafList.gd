extends VBoxContainer

const _LEAF_DIR := "res://assets/library/leaves/"
const LEAF_TEX := preload("res://scenes/leaf/LeafTex.tscn")
onready var VIEW_PORT := $"../../System/ViewContainer/Viewport"

func _ready() -> void:
	xload_leaves()

func xload_leaves() -> void:
	var file_paths : Array = get_file_paths_in_folder(_LEAF_DIR)
	for i in file_paths:
		var _img := ResourceLoader.load(i, "", true) as Image
		_img.convert(Image.FORMAT_RGBA8) #WTF
		G.leaf_list.append(_img)

		var copy : Image = Image.new()
		copy = ResourceLoader.load(i, "", true) as Image
		copy.convert(Image.FORMAT_RGBA8)
		copy.copy_from(_img)
		copy.resize(128, 128, Image.INTERPOLATE_NEAREST) #WTF #DELETE #FIXIT

		var _img_tex := ImageTexture.new()
		_img_tex.create_from_image(copy, 0)

		var leaf_tex_spawn = LEAF_TEX.instance()
		leaf_tex_spawn.connect("attach_leaf", self, "attach_leaf")
		leaf_tex_spawn.texture_normal = _img_tex

		add_child(leaf_tex_spawn)
#


func attach_leaf(a_leaf) -> void:
	VIEW_PORT.add_child(a_leaf, true)


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


