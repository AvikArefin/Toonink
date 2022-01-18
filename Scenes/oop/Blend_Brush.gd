extends Object
class_name Blend_Brush

static func draw(img_storage : Image, pos: Vector2) -> void:
  img_storage.blend_rect(G.brush, G.brush_rect, pos - G.brush_dis)
