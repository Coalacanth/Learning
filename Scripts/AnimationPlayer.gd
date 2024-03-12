extends AnimationPlayer

@onready var animation_player = $"."

func _ready():
	pass

func _on_character_body_3d_walk_animation(new_direction):
	if new_direction:
		animation_player.play("Running_A")
	else :
		animation_player.play("Idle")

