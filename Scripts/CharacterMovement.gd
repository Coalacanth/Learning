extends CharacterBody3D

@onready var pivot = $Pivot
@onready var navigation_agent = $NavigationAgent3D

signal walk_animation(new_direction)

@export var movement_speed = 5

const JUMP_VELOCITY = 4.5

var movement_target_position = Vector3.ZERO
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5
	
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	set_movement_target(global_position + Vector3.FORWARD * 3)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if navigation_agent.is_navigation_finished():
		emit_signal("walk_animation", false)
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	
	pivot.look_at(next_path_position)
	
	emit_signal("walk_animation",not navigation_agent.is_navigation_finished())
	
	move_and_slide()
	

func _on_button_pressed():
	var vect: Vector3 = Vector3(randi_range(3, 10),0,randi_range(3, 10))
	if navigation_agent.is_navigation_finished():
		print("pressed ", vect)
		set_movement_target(vect)
