extends TileMap
class_name RandomLevelGenerator

var border := Rect2i(-43, -31, 126, 75)

func _ready() -> void:
	gen_levl()

func gen_levl() -> void:
	var walker := Walker.new(get_random_cell(Vector2i(0, 0)), border)
	var map := walker.turn(1000)
	walker.queue_free()
	for lc in map:
		erase_cell(0, lc)
	
	var s_walker := Walker.new(map.pick_random(), border)
	var s_map := s_walker.turn(5000)
	for lc in s_map:
		erase_cell(0, lc)
	s_walker = Walker.new(get_random_cell(Vector2i(0, 0)), border)
	s_map = s_walker.turn(5000)

func get_random_cell(usd_cell_crd: Vector2i) -> Vector2i:
	var _local_border := Rect2i(125, 125, 250, 250)
	var cell: Vector2i = get_used_cells_by_id(0, 0, usd_cell_crd).pick_random()
	while !border.has_point(cell):
		cell = get_used_cells(0).pick_random()
	
	return cell

func _input(_e: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()

func center_filter(num: Vector2i) -> bool:
	var local_border := Rect2i(125, 125, 250, 250)
	return local_border.has_point(num)
