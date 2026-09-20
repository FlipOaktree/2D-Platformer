# Generates terrain_peering_reference.png, the peering-bit reference for
# terrain.png used by Module 4, Lesson 2.
#
# The marks are not hand-authored. Godot's "Using TileSets" page publishes the
# same tilesheet twice, once plain and once with its terrain configured:
#   _images/using_tilesets_terrain_example_tilesheet.webp
#   _images/using_tilesets_terrain_example_tilesheet_configuration.webp
# Both are 769x257 with 64-pixel tiles, matching terrain.png at 768x256. Differencing them per tile across nine
# sample regions - centre, four sides, four corners - gives a clean bimodal
# signal: about 1.0 where the terrain is marked and 0.0 where it is not. Those
# results are drawn onto terrain.png, then scaled 2x so the marks stay legible.
#
# The output was checked against a tileset configured by hand in the editor:
# all 47 tiles and all 376 peering bits matched.
#
# To re-run, place the two .webp files and terrain.png under
# res://levels/tiles/ in any Godot 4.7 project and run this as a --script.


extends SceneTree

const S := 64    # docs tile size
const T := 64    # our tile size
const SPOTS := {
	"C": Vector2i(32,32), "T": Vector2i(32,6), "R": Vector2i(58,32),
	"B": Vector2i(32,58), "L": Vector2i(6,32), "TL": Vector2i(8,8),
	"TR": Vector2i(56,8), "BR": Vector2i(56,56), "BL": Vector2i(8,56),
}
const ORDER := ["C","T","R","B","L","TL","TR","BR","BL"]
const HOLE := Vector2i(10,1)

func _d(a: Image, b: Image, px: int, py: int) -> float:
	var tot := 0.0
	for dy in range(-3,4):
		for dx in range(-3,4):
			var x: int = clampi(px+dx,0,a.get_width()-1)
			var y: int = clampi(py+dy,0,a.get_height()-1)
			var d: Color = a.get_pixel(x,y) - b.get_pixel(x,y)
			tot += absf(d.r)+absf(d.g)+absf(d.b)
	return tot/49.0

func _box(img: Image, x: int, y: int, w: int, h: int, fill: Color, edge: Color) -> void:
	img.fill_rect(Rect2i(x-1, y-1, w+2, h+2), edge)
	img.fill_rect(Rect2i(x, y, w, h), fill)

func _init() -> void:
	var a := Image.load_from_file("res://levels/tiles/using_tilesets_terrain_example_tilesheet.webp")
	var b := Image.load_from_file("res://levels/tiles/using_tilesets_terrain_example_tilesheet_configuration.webp")
	var img := Image.load_from_file("res://levels/tiles/terrain.png")
	img.convert(Image.FORMAT_RGBA8)

	var green := Color(0.49, 1.0, 0.24, 1.0)
	var edge := Color(0.05, 0.12, 0.02, 1.0)
	var grid := Color(1.0, 0.45, 0.1, 1.0)

	for cy in 4:
		for cx in 12:
			# grid lines
			img.fill_rect(Rect2i(cx*T, cy*T, T, 1), grid)
			img.fill_rect(Rect2i(cx*T, cy*T, 1, T), grid)
			if Vector2i(cx, cy) == HOLE:
				continue
			for k in ORDER:
				var s: Vector2i = SPOTS[k]
				if _d(a, b, cx*S+s.x, cy*S+s.y) <= 0.5:
					continue
				var ox := cx*T
				var oy := cy*T
				match k:
					"C":  _box(img, ox+22, oy+22, 20, 20, green, edge)
					"T":  _box(img, ox+25, oy+4,  14, 8, green, edge)
					"B":  _box(img, ox+25, oy+52, 14, 8, green, edge)
					"L":  _box(img, ox+4,  oy+25, 8, 14, green, edge)
					"R":  _box(img, ox+52, oy+25, 8, 14, green, edge)
					"TL": _box(img, ox+4,  oy+4,  10, 10, green, edge)
					"TR": _box(img, ox+50, oy+4,  10, 10, green, edge)
					"BL": _box(img, ox+4,  oy+50, 10, 10, green, edge)
					"BR": _box(img, ox+50, oy+50, 10, 10, green, edge)
	img.resize(img.get_width() * 2, img.get_height() * 2, Image.INTERPOLATE_NEAREST)
	print("save = ", img.save_png("user://terrain_peering_reference.png"), "  size = ", img.get_size())
	quit()
