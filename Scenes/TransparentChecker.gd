extends ColorRect

onready var View : Viewport = $".."

func _ready() -> void:
	update_rect()

func update_rect() -> void:
	rect_size = View.get_size()


