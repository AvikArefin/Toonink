extends Object
class_name Blit_Brush

static func draw(img_storage: Image, pos: Vector2) -> void:
  img_storage.blit_rect_mask(G.blit_brush, G.brush, G.brush_rect, pos - G.brush_dis)

