extends Object
class_name Pixel

static func draw(img_storage: Image, pos: Vector2) -> void:
	img_storage.set_pixelv(pos, G.cross_color)
