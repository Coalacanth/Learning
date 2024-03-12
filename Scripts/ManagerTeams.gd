extends Node3D

#necesito que los aliados esten en el teamA, los enemigos en el teamB y los neutrales en el teamC
#dependiendo del team al que pertenece, se le da acceso a quien atacar
const ally = "Ally"
const enemy = "Enemy"
const neutral = "Neutral"

var list_teams

func _ready():
	if list_teams == null: list_teams = get_children()
	

func add_team(unit):
	if unit == null: return
	
	match get_group_team(unit):
		ally:
			list_teams[0].add_child(unit)
			return ally
		enemy:
			list_teams[1].add_child(unit)
			return enemy
		neutral:
			list_teams[2].add_child(unit)
			return neutral

func get_group_team(unit):
	var list_group = unit.get_groups()
	
	for i in range(list_group.size()):
		match list_group[i]:
			ally:
				return ally
			enemy:
				return enemy
			neutral:
				return neutral
