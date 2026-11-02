extends CharacterBody3D

@export var speed := 7.0
@export var jump_velocity := 5.5
var gravity := 18.0

func _ready() -> void:
	_build_bread()

func _build_bread() -> void:
	var body := MeshInstance3D.new()
	var mesh := CapsuleMesh.new()
	mesh.radius = 0.48
	mesh.height = 1.45
	body.mesh = mesh
	body.position.y = 0.9
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.78, 0.48, 0.22)
	body.material_override = mat
	add_child(body)
	for side in [-1.0, 1.0]:
		var eye := MeshInstance3D.new()
		var eye_mesh := SphereMesh.new()
		eye_mesh.radius = 0.085
		eye_mesh.height = 0.17
		eye.mesh = eye_mesh
		eye.position = Vector3(side * 0.17, 1.12, -0.405)
		var eye_mat := StandardMaterial3D.new()
		eye_mat.albedo_color = Color.WHITE
		eye.material_override = eye_mat
		add_child(eye)
		var pupil := MeshInstance3D.new()
		var pupil_mesh := SphereMesh.new()
		pupil_mesh.radius = 0.035
		pupil_mesh.height = 0.07
		pupil.mesh = pupil_mesh
		pupil.position = Vector3(side * 0.17, 1.12, -0.48)
		add_child(pupil)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		rotation.y = lerp_angle(rotation.y, atan2(-direction.x, -direction.z), delta * 10.0)
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed * delta * 4.0)
		velocity.z = move_toward(velocity.z, 0.0, speed * delta * 4.0)
	move_and_slide()
