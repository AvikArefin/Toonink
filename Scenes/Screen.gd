extends Node2D

onready var screen_rect : Rect2 = get_viewport_rect()
var is_allowed : bool = true

var previous_pos : Vector2
var final_pos : Vector2

var img_storage : Image
var img_texture : ImageTexture = ImageTexture.new()
#--------------------------------------------------------------------------
var current_mode : GDScript = Blend_Brush

#------Use of class for the sake of not having to check the tool all the time--------
enum Modes { BRUSH = 0, ERASER = 1, PIXEL = 2, BLIT_BRUSH = 3}
const MODES = {
	Modes.BRUSH : Blend_Brush,
	Modes.ERASER : Eraser,
	Modes.PIXEL : Pixel,
	Modes.BLIT_BRUSH : Blit_Brush
}


func change_mode(index: int) -> void:
	G.mode = index
	img_storage.lock()  # why does the image get unlocked in the middle of nowhere
	current_mode = MODES[G.mode]
	
	G.reinitialize()
	

	
#----------------change brush-------------------------------------------

func change_brush(index: int) -> void:
	print('change brush')
	G.brush = G.brush_list[index] ####
	G.brush_rect = G.brush.get_used_rect() ####
	
	G.reinitialize()
#-----------------------------------------------------------------------

func _ready() -> void:
#	G.zoom_able = false # Valueless for the moment
	create_new_image()

func create_new_image():
	var img := Image.new()
	img.create(G.window_size_x, G.window_size_y, true, Image.FORMAT_RGBA8)
	img_storage = img
	img_storage.lock()
	update()

var item_goes_brr : Vector2
#----------------------------INPUT-SYSTEM--------------------------------
func _input(event):
	if screen_rect.has_point(get_global_mouse_position()) && is_allowed:
		if event.is_action_pressed("primary"):
			previous_pos = get_local_mouse_position().round()
			current_mode.draw(img_storage, previous_pos)
			update()
#		elif Input.is_action_pressed("wheel_up"):
#			position.x -= 10
#		elif Input.is_action_pressed("wheel_down"):
#			position.x += 10

#		Make a script so that you can not go beyond the veiwport
#		food for thought, what would you do when implementing the
#		zoom mechanic?

		if event is InputEventMouseMotion:
			if Input.is_action_pressed("primary"):
				final_pos = get_local_mouse_position().round()
				print(final_pos)
				draw_fill_gap(previous_pos, final_pos)
#				current_mode.draw(img_storage, previous_pos)
				previous_pos = final_pos
				update()


func draw_fill_gap(start : Vector2, end : Vector2) -> void:
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
			
		current_mode.draw(img_storage, Vector2(x, y))


#----------------------------------Renderer---------------------------
func _draw():
	img_texture.create_from_image(img_storage)
	draw_texture(img_texture, Vector2.ZERO)


# --------------------------Color x Size ----------------------------
onready var Background : Node2D = $"../Background" as Node2D

# when color droper is selected
func color_dropper_toggle_is_allowed() -> void:
	is_allowed = !is_allowed
#	when the color_droper is closed
	if is_allowed:
		previous_pos = get_local_mouse_position()

#		change the brush color now..
		G.blit_brush.fill(G.cross_color)

#		change the background color now..
		Background.update()

func _on_size_value_changed(value: float) -> void:
	G.size = int(value)
	
	G.reinitialize()
	

func change_color(color: Color) -> void:
	G.cross_color = color

