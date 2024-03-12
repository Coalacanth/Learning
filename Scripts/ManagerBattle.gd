extends Node3D

var is_battle: bool = false
var list_enemys = []
var path_enemys = "res://Characters/Enemys"

@onready var teams = $"../Teams"

func _ready():
	set_enemy_list(path_enemys)
	#add_enemy(position)
	is_battle = true


func add_enemy(position_enemy:Vector3, enemy):
	var team_b = teams.get_child(1)
	#var enemy = list_enemys[0].instantiate()
	team_b.add_child(enemy)
	enemy.position = position_enemy

func set_enemy_list(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print(file_name)
			if not dir.current_is_dir():
				list_enemys.append(load(path_enemys + "/" + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
