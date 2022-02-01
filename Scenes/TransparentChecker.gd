extends ColorRect

onready var VIEW : Viewport = $".."

func _ready() -> void:
	update_rect()

func update_rect() -> void:
	rect_size = VIEW.get_size()
