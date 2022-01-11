extends ItemList

onready var LINE_EDIT : LineEdit = $LineEdit
onready var VIEW_PORT : Viewport = $"../../System/ViewContainer/Viewport"
onready var LAYER_LABEL : Label = $Label
var layers_count : int

func _ready() -> void:
	_refresh()


func _on_Add_pressed() -> void:
	_on_LineEdit_text_entered(LINE_EDIT.text)

func _on_LineEdit_text_entered(new_text: String) -> void:
	if new_text != '':
		var another_node_2d : Node2D = Node2D.new()
		another_node_2d.set_name(new_text)
		VIEW_PORT.add_child(another_node_2d)
		
		_refresh()
		LINE_EDIT.text = ''

func _on_Remove_pressed() -> void:
	VIEW_PORT.get_child(G.selected_layer).queue_free()
	yield(get_tree(), "idle_frame") # The "removing" and "refreshing" are happening at the same time as they 
	_refresh() #  are triggered without delay after pressing remove, it won't work. That is why yield is being used.
	
func _on_Layers_item_selected(index: int) -> void:
	G.selected_layer = index
	
#	set up layer_lv label
	LAYER_LABEL.text = "Selected Layer: " + str(index + 1) + "/" + str(layers_count)


func _refresh() -> void:
	clear()
	
	layers_count = VIEW_PORT.get_child_count()
#	refreshing the UI
	for i in layers_count:
		add_item(VIEW_PORT.get_child(i).name, null, true)
	
