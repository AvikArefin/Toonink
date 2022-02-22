extends Node2D

var multi_dots : PoolVector2Array 

var lines : int = 10
var start : int = 1
var finish : int = 1000
var step : int = 50
var line_width : float = 1.0
var line_radius : float = 1.0
var line_color : Color = Color.black

var space : int = 50

var tex := ImageTexture.new()

var _graph_no : int = 0
# 1 = line; 2 = circles; 3 = texture background |

var background := Image.new()

func _ready() -> void:
	change_background(4)

func change_line_color(color: Color) -> void:
	line_color = color

func change_background(index: int) -> void:
	multi_dots = []
	match index:
		0:
			none()
		1:
			line()
		2:
			grid()
		3:
			box()
		4:
			slanted()
		5:
			dotted()
		6:
			colored()
		7:
			picture()
			
#	print_debug(multi_dots)
	update()


func none() -> void:
#	background = Texture.new()
	_graph_no = 0
	

func line() -> void:
	for y in range(0, G.window_size_y, step):
		for x in [0, G.window_size_x]:
			multi_dots.append(Vector2(x, y))
	_graph_no = 1
	

func grid() -> void:
	for y in range(0, G.window_size_y, step):
		for x in [0, G.window_size_x]:
			multi_dots.append(Vector2(x, y))
			
	for x in range(0, G.window_size_x, step):
		for y in [0, G.window_size_y]:
			multi_dots.append(Vector2(x, y))
	_graph_no = 1
	


func box() -> void:
	for y in range(1, G.window_size_y - 1, 50):
		for x in range(1, G.window_size_x - 1, 50):
			multi_dots.append(Vector2(x, y))
		
	for x in range(0, G.window_size_x, 50):
		for y in range(0, G.window_size_y, 50):
			multi_dots.append((Vector2(x, y)))
	_graph_no = 1
	

func slanted() -> void:
	var x :int = 25
	var y :int = 15
	var multi_dots_odd : PoolVector2Array = []
	for j in range(1, y+1):
		var a : int = 0
		multi_dots_odd.append(Vector2(a, j))
		if (j== y):
			for i in range(a+1, x+1):
				if (i==x):
					pass
				else:
					multi_dots_odd.append(Vector2(i, j))
	
	var multi_dots_even : PoolVector2Array = []
	for i in range(1, x+1):
		var a : int = 0
		multi_dots_even.append(Vector2(i, a))
		if (i==x):
			for j in range(a+1, x+1):
				if (j==y):
					pass
				else:
					multi_dots_even.append(Vector2(i, j))
	
	for i in multi_dots_odd.size():
		multi_dots.append(multi_dots_odd[i]*space)
		multi_dots.append(multi_dots_even[i]*space)
	
	_graph_no = 1


func dotted() -> void:
	for x in range(0, G.window_size_x, step):
		for y in range(0, G.window_size_y, step):
			multi_dots.append(Vector2(x, y))
	_graph_no = 2
	


func colored() -> void:
	_graph_no = 3
#	give the user the chioce to select the background on their own.
	background.create(G.window_size_x, G.window_size_y, true, Image.FORMAT_RGBA8)

func picture() -> void:
	_graph_no = 4
#	give the user the chioce to select the background on their own.
#	background.create(G.window_size_x, G.window_size_y, true, Image.FORMAT_RGBA8)
	pass
	


func _draw() -> void:
	match _graph_no:
		0:
			pass#	clears the background
		1:
			draw_multiline(multi_dots, line_color, line_width, true)
		2:
			for _pos in multi_dots:
				draw_circle(_pos, line_radius, line_color)
		3:
			background.fill(line_color)
			tex.create_from_image(background, 0)
			draw_texture(tex, Vector2.ZERO)
		4:
			tex.create_from_image(background, 0)
			draw_texture(tex, Vector2.ZERO)





