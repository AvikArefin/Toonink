extends OptionButton

onready var SCREEN : Node2D = $"../../../System/ViewContainer/Viewport/Screen"

func _on_Mode_item_selected(index: int) -> void:
	SCREEN.img_storage.lock()
	G.change_mode(index)
