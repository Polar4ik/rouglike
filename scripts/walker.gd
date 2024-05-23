extends Node
class_name Walker

var DIR := [Vector2i.DOWN, Vector2i.LEFT, Vector2i.UP, Vector2i.RIGHT]
var rng := RandomNumberGenerator.new()

var pos := Vector2i.ZERO
var dir := Vector2i.RIGHT
var bord := Rect2i()

var stack: Array[Vector2i] = []

func _init(n_pos: Vector2i, n_bord: Rect2i) -> void:
	assert(n_bord.has_point(n_pos))
	pos = n_pos
	bord = n_bord
	
	stack.push_back(n_pos)

func turn(n: int) -> Array[Vector2i]:
	for i in n:
		if rng.randf() >= 0.5:
			new_dir()
		
		if step():
			stack.push_back(pos)
		else:
			new_dir()
	
	return stack

func step() -> bool:
	var trg_pos := pos + dir
	if bord.has_point(trg_pos):
		pos = trg_pos
		return true
	else:
		return false

func new_dir() -> void:
	var direct := DIR.duplicate()
	direct.erase(dir)
	
	direct.shuffle()
	
	dir = direct.pick_random()
	
	while !bord.has_point(pos + dir):
		dir = direct.pick_random()
