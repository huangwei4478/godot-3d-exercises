class_name Enemy

extends CharacterBody3D

@onready var navigation_agent_3d = $NavigationAgent3D
@onready var animation_player = $AnimationPlayer

@export var max_hitpoints := 100

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var player = null

var provoked := false
var approach_range := 12.0
var hitpoints: int = max_hitpoints:
	set(value):
		hitpoints = value
		if hitpoints <= 0:
			queue_free()
		provoked = true

@export var attack_range := 1.5
@export var attack_damage := 20

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _process(_delta):
	if provoked:
		navigation_agent_3d.target_position = player.global_position
	
func _physics_process(delta):
	var next_position = navigation_agent_3d.get_next_path_position()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = global_position.direction_to(next_position)
	var distance = global_position.distance_to(player.global_position)
	
	if distance >= approach_range:
		provoked = false
	else:
		provoked = true
		if distance <= attack_range:
			animation_player.play("attack")
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		look_at_target(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func look_at_target(direction: Vector3):
	var adjusted_direction = direction
	adjusted_direction.y = 0
	look_at(global_position + adjusted_direction, Vector3.UP, true)
	
func attack():
	print("Enemy attack!")
	player.hitpoints -= attack_damage
