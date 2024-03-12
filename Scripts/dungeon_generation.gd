@tool
extends Node3D

@onready var grid_map: GridMap = $GridMap


@export var start: bool = false : set = set_start
func set_start(val:bool)->void:
	generate()

@export var border_size : int = 20 : set = set_border_size
func set_border_size(val:int)->void:
	border_size = val
	if Engine.is_editor_hint():
		visualize_border()

@export var room_number: int = 4
@export var room_margin: int = 1
@export var room_recursion: int = 15
@export var min_room_size: int = 2
@export var max_room_size: int = 4

func visualize_border():
	grid_map.clear()
	for i in range(-1,border_size+1):
		grid_map.set_cell_item(Vector3i(i,0,-1),3)
		grid_map.set_cell_item(Vector3i(i,0,border_size),3)
		grid_map.set_cell_item(Vector3i(border_size,0,i),3)
		grid_map.set_cell_item(Vector3i(-1,0,i),3)

func generate():
	visualize_border()
	for i in room_number:
		make_room(room_recursion)

func make_room(recursion:int):
	if !recursion>0:
		return
	
	var width: int = (randi() % (max_room_size - min_room_size)) + min_room_size
	var height: int = (randi() % (max_room_size - min_room_size)) + min_room_size
	
	var start_pos: Vector3i
	start_pos.x = randi() % (border_size - width + 1)
	start_pos.z = randi() % (border_size - height + 1)
	
	for r in range(-room_margin, height + room_margin):
		for c in range(-room_margin, width + room_margin):
			var pos: Vector3i = start_pos + Vector3i(c,0,r)
			if grid_map.get_cell_item(pos) == 0:
				make_room(recursion-1)
				return
	
	for r in height:
		for c in width:
			var pos: Vector3i = start_pos + Vector3i(c,0,r)
			grid_map.set_cell_item(pos,0)

