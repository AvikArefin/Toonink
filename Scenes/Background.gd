extends Node2D

var background : Texture 
var multi_dots : PoolVector2Array = []

var lines : int = 10
var start : int = 1
var finish : int = 1000
var step : int = 50
var line_width : float = 1.0
var line_radius : float = 1.0
var line_color : Color = Color.red

var _graph_no : int = 2
# 1 = line; 2 = circles; 3 = texture background |

func _ready() -> void:
	line()
	pass

# Do some code cleanup..
func change_background(index: int) -> void:
	match index:
		0:
			line()
		1:
			grid()
		2:
			box()
		3:
			slanted()
		4:
			dotted()


func line() -> void:
#	var step : float = (finish - start)/lines as float
	for y in range(start, finish, step):
		for x in range(0, 501, 500):
			multi_dots.append(Vector2(x, y))
#	print(multi_dots)
	_graph_no = 1
	update()


func grid() -> void:
#	var step : float = (finish - start)/lines as float
	for y in range(start, finish, step):
		for x in range(0, 501, 500):
			multi_dots.append(Vector2(x, y))
			
	for x in range(start, finish, step):
		for y in range(0, 501, 500):
			multi_dots.append(Vector2(x, y))
#	print(multi_dots)
	_graph_no = 1	
	update()


func box() -> void:
	for x in range(1, 500, 50):
		for y in range(1, 500, 50):
			multi_dots.append(Vector2(y, x))
	for x in range(1, 500, 50):
		for y in range(1, 500, 50):
			multi_dots.append((Vector2(x, y)))
	_graph_no = 1	
	update()


func slanted() -> void:
#	var step : float = (finish - start)/lines as float
	for y in range(start, finish, step):
		for x in range(start, finish, step):
			multi_dots.append(Vector2(x, y))
			multi_dots.append(Vector2(y, x))
	_graph_no = 1
	update()


func dotted() -> void:
	for x in range(start, finish, step):
		for y in range(start, finish, step):
			multi_dots.append(Vector2(x, y))
	_graph_no = 2
	update()


func picture() -> void:
	_graph_no = 3
#	give the user the chioce to select the background on their own.
	update()

func _draw() -> void:
	match _graph_no:
		1:
			draw_multiline(multi_dots, line_color, line_width, true)
		2:
			for _pos in multi_dots:
				draw_circle(_pos, line_radius, line_color)
		3:
			draw_texture(background, Vector2.ZERO)

# Ability to customize the values of the properties....
