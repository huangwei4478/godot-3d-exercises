extends RigidBody3D

## How much vertical force to apply when moving
@export_range(350.0, 3000.0) var thrust: float = 1000.0

## How much torque force to apply when moving
@export var torque: float = 100.0

@onready var explosion_audio: AudioStreamPlayer = $ExplosionAudio
@onready var success_audio: AudioStreamPlayer = $SuccessAudio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles

var is_transitioning: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
		
	if Input.is_action_just_pressed("boost"):
		rocket_audio.play()
		booster_particles.emitting = true
		
	if Input.is_action_just_released("boost"):
		rocket_audio.stop()
		booster_particles.emitting = false
	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0, 0, delta * torque));
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0, 0, -delta * torque));


func _on_body_entered(body: Node) -> void:
	if is_transitioning:
		return
	
	if "Goal" in body.get_groups():
		complete_level(body.next_level_file)
		
	if "Failure" in body.get_groups():
		crash_sequence()

func crash_sequence() -> void:
	explosion_audio.play()
	booster_particles.emitting = false
	explosion_particles.emitting = true
	is_transitioning = true
	set_process(false)
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(get_tree().reload_current_scene)
	
func complete_level(next_level_file: String) -> void:
	success_audio.play()
	is_transitioning = true
	success_particles.emitting = true
	set_process(false)
	
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))
	
