extends Object
class_name Eraser

static func draw(img_storage: Image, pos: Vector2) -> void:
	img_storage.blit_rect_mask(G.eraser, G.brush, G.brush_rect, pos)
