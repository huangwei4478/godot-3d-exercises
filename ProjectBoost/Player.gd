extends RigidBody3D

## How much vertical force to apply when moving
@export_range(350.0, 3000.0) var thrust: float = 1000.0

## How much torque force to apply when moving
@export var torque: float = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0, 0, delta * torque));
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0, 0, -delta * torque));


func _on_body_entered(body: Node) -> void:
	if "Goal" in body.get_groups():
		print("you won!")
		
	if "Failure" in body.get_groups():
		print("you lost!")
