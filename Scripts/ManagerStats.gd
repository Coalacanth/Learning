extends Node3D

var level = 1
var experience
var max_experience

func _ready():
	
	set_next_level_exp()

func add_experience(expValue):
	var acum_exp = expValue + experience
	
	#level up
	while acum_exp >= max_experience:
		acum_exp -= experience
		level_up()
	
	#no level up
	#if acum_exp < experience.maximum_value:
	experience += acum_exp

func set_next_level_exp():
	max_experience = level + 1

func level_up():
	#setting the level up
	level += 1
	set_next_level_exp()
	#change stats
