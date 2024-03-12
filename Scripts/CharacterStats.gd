extends Node3D

#Resources
@export var stats : StatsResource
@onready var root_name = $"../.."
#Traverse Stats
var jump_power = 1.0
var movement = 5.0

func _ready():
	set_stats()

func set_stats():
	if stats == null:
		stats = load("res://Characters/Allys/" + root_name + ".tres")

