extends OptionButton

onready var SCREEN : Node2D = $"../../../System/ViewContainer/Viewport/Screen"
# ^^^ 4.0 deprecated as the need to lock is no more.

func _on_Mode_item_selected(index: int) -> void:
	SCREEN.img_storage.lock() # 4.0 deprecated
	G.change_mode(index)
