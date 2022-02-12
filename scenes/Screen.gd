extends Node2D

onready var SCREEN_RECT : Rect2 = get_viewport_rect()

func update_screen_rect() -> void:
	SCREEN_RECT = Rect2(0, 0, G.stored_img_x, G.stored_img_y)

var is_allowed : bool = true

var previous_pos : Vector2
var final_pos : Vector2

var img_storage : Image
var img_texture : ImageTexture = ImageTexture.new()


#------------------------------------------------------------------------------
func _ready() -> void:
	create_new_image()


func create_new_image():
	var img := Image.new()
	img.create(G.window_size_x, G.window_size_y, true, Image.FORMAT_RGBA8)
	img_storage = img
	img_storage.lock()
	update()

#---------------------------- INPUT-SYSTEM ------------------------------------
func _input(event):
	if SCREEN_RECT.has_point(get_global_mouse_position()) && is_allowed:
#		print(screen_rect)
		if event.is_action_pressed("primary"):
			previous_pos = get_local_mouse_position().round()
			G.current_mode.draw(img_storage, previous_pos)
			update()


		if event is InputEventMouseMotion:
			if Input.is_action_pressed("primary"):
				final_pos = get_local_mouse_position().round()
#				print(final_pos)
				fill_in_the_gap(previous_pos, final_pos)
#				current_mode.draw(img_storage, previous_pos)
				previous_pos = final_pos
				update()


func fill_in_the_gap(start : Vector2, end : Vector2) -> void:
	var dx := int(abs(end.x - start.x))
	var dy := int(-abs(end.y - start.y))
	var err := dx + dy
	var e2 := err << 1
	var sx = 1 if start.x < end.x else -1
	var sy = 1 if start.y < end.y else -1
	var x = start.x
	var y = start.y
	while !(x == end.x && y == end.y):
		e2 = err << 1
		if e2 >= dy:
			err += dy
			x += sx
		if e2 <= dx:
			err += dx
			y += sy
			
		G.current_mode.draw(img_storage, Vector2(x, y))


#------------------------------- Renderer -------------------------------------
func _draw():
	img_texture.create_from_image(img_storage, 0)
	draw_texture(img_texture, Vector2.ZERO)

#------------------------------------------------------------------------------
func change_color(color: Color) -> void:
	G.cross_color = color

func _on_BgColorDroper_color_changed(color: Color) -> void:
	G.bg_color = color
# TODO this is not used yet...

#---------------------------- Control SYSTEM ----------------------------------

onready var TEXTPORT : TextEdit = $"../TextPort" as TextEdit

func configure_mode(extra_arg_0: int) -> void:
	is_allowed = false
	G.zoom_able = false
	
	TEXTPORT.mouse_filter = Control.MOUSE_FILTER_IGNORE
	match extra_arg_0:
		0:
			print('about popup about to show')
		1:
			print("ColorDropper pressed")
		2:
			print("mode pressed")
		3:
			print("projectloader popup about to show up")
		4:
			print("ShaderButton pressed")
		5:
			print("BgColorDropper pressed")
		7:
			print("Project Creator about to show")


func _on_Mode_item_selected(_index: int, extra_arg_0: int) -> void:
	create_mode(extra_arg_0)

func _on_ShaderButton_item_selected(_index: int, extra_arg_0: int) -> void:
	create_mode(extra_arg_0)


func create_mode(extra_arg_0: int) -> void:
	is_allowed = true
	G.zoom_able = true

	TEXTPORT.mouse_filter = Control.MOUSE_FILTER_STOP
	match extra_arg_0:
#	fix of the unwanted drawing... # TODO write an if statement to check which hide function was executed.
		0:
			print('about popup hide')
		1:
			print("ColorDropper popup closed")
#			means its time to update the blit brush color
			G.blit_brush.fill(G.cross_color)
			previous_pos = get_local_mouse_position()
		2:
			print("mode")
		3:
			print("projectloader popup about to hide")
		4:
			print("ShaderButton item selected")
		5:
			print("BgColorDropper popup closed")
			previous_pos = get_local_mouse_position()
		7:
			print("Project Creator ???")
		
#			TODO Change the color of the shader primary color in the shaders

# BUG TODO you have to load a picture twice to be able to draw on it... why?
