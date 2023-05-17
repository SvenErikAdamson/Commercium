extends Sprite2D


#func _ready():
#	sprite_to_polygon()
#
#func sprite_to_polygon():
#	var bitmap = BitMap.new()
#	bitmap.create_from_image_alpha(texture.get_image())
#	var polys = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO,texture.get_size()))
#	for poly in polys:
#		var collision_polygon = CollisionPolygon2D.new()
#		collision_polygon.polygon = poly
#		add_child(collision_polygon)
##		if centered:
##			collision_polygon.position -= bitmap.get_size() /2
#
