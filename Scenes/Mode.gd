extends OptionButton

onready var Screen : Node2D = $"../../../System/ViewContainer/Viewport/Screen"#WTF

func _on_Mode_item_selected(index: int) -> void:
	Screen.img_storage.lock()
	G.change_mode(index)
