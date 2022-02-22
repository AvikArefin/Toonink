extends TextureRect

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

func create_new_image() -> void:
	var img := Image.new()
	img.create(G.stored_img_x, G.stored_img_y, false, Image.FORMAT_RGBA8)
	img_storage = img
	img_storage.lock() # 4.0 deprecated
	update()
	update_screen_texture()

func clear_image() -> void:
	img_texture = ImageTexture.new()
	img_texture.create(G.stored_img_x, G.stored_img_y, Image.FORMAT_RGBA8, 0)
	texture = img_texture

#---------------------------- INPUT-SYSTEM ------------------------------------
func _input(event: InputEvent) -> void:
	if SCREEN_RECT.has_point(get_global_mouse_position()):
#		print_debug(screen_rect)
		if event.is_action_pressed("primary"):
			previous_pos = get_local_mouse_position().round()
			G.current_mode.draw(img_storage, previous_pos)
			update_screen_texture()

# Is there a way to reduce the time img_storage is sent as a variable?

		if event is InputEventMouseMotion:
			if Input.is_action_pressed("primary"):
				final_pos = get_local_mouse_position().round()
#				print_debug(final_pos)
				fill_in_the_gap(previous_pos, final_pos)
#				current_mode.draw(img_storage, previous_pos)
				previous_pos = final_pos
				update_screen_texture()


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

# TODO 
# Optimizations: The drawing gets slower when the drawing screen too large.
# Enhancements: When drawing faster the lines becomes robotic.

# Perhaps a lerp function will do better to make the lines smoother.

#-------------------------------Final Renderer -------------------------------------
func update_screen_texture() -> void:				#
	img_texture.create_from_image(img_storage, 0)	# When the Screen is TextureRect
	texture = img_texture							#

#------------------------------------------------------------------------------

func _on_FgColor_color_changed(color: Color) -> void:
	G.cross_color = color

func _on_BgColor_color_changed(color: Color) -> void:
	G.bg_color = color

#---------------------------- Control SYSTEM ----------------------------------

onready var TEXTPORT : TextEdit = $"../TextPort" as TextEdit
onready var VIEW : Camera2D = $"../view" as Camera2D


var time_first := OS.get_unix_time()
var time_second := OS.get_unix_time()
var time_elapsed := OS.get_unix_time()

func configure_mode(arg : int) -> void:
	get_tree().paused = true
#	is_allowed = false
#	G.zoom_able = false
	
#	TEXTPORT.mouse_filter = Control.MOUSE_FILTER_IGNORE
#	TEXTPORT.pause_mode = Node.PAUSE_MODE_STOP	
	if arg == 0:
		print_debug('about popup about to show')
	elif arg == 1:
		print_debug("ColorDropper pressed")
	elif arg == 2:
		print_debug("mode pressed")
	elif arg == 3:
		print_debug("projectloader popup about to show up")
	elif arg == 4:
		print_debug("ShaderButton pressed")
	elif arg == 5:
		print_debug("BgColorDropper pressed")
	elif arg == 7:
		print_debug("Project Creator about to show")


func _on_Mode_item_selected(_index: int, extra_arg_0: int) -> void:
	create_mode(extra_arg_0)

func _on_ShaderButton_item_selected(_index: int, extra_arg_0: int) -> void:
	create_mode(extra_arg_0)


func create_mode(arg: int) -> void:
	get_tree().paused = false
#	is_allowed = true
#	G.zoom_able = true
	if arg == 0:
			print_debug('about popup hide')
	elif arg == 1:
			print_debug("ColorDropper popup closed")
#			means its time to update the blit brush color
			G.blit_brush.fill(G.cross_color)
			previous_pos = get_local_mouse_position()
	elif arg == 2:
			print_debug("mode")
	elif arg == 3:
			print_debug("projectloader popup about to hide")
	elif arg == 4:
			print_debug("ShaderButton item selected")
	elif arg == 5:
			print_debug("BgColorDropper popup closed")
			#	fix of the unwanted drawing... 
			previous_pos = get_local_mouse_position()
	elif arg == 7:
			print_debug("Project Creator hide popup")

# TODO ONLY KEEP THE INPUT SYSTEM HERE...


