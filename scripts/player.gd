extends CharacterBody3D
@export var speed := 6.5
var gravity := 18.0
var mobile_move := Vector2.ZERO
var mobile_jump := false
func _ready() -> void:
	var bread := MeshInstance3D.new()
	var shape := CapsuleMesh.new()
	shape.radius = 0.43
	shape.height = 1.35
	bread.mesh = shape
	bread.position.y = 0.85
	var crust := StandardMaterial3D.new()
	crust.albedo_color = Color(0.78,0.48,0.22)
	bread.material_override = crust
	add_child(bread)
	for side in [-1.0,1.0]:
		var eye := MeshInstance3D.new()
		var em := SphereMesh.new()
		em.radius = 0.09
		em.height = 0.18
		eye.mesh = em
		eye.position = Vector3(side*0.16,1.05,-0.37)
		var white := StandardMaterial3D.new()
		white.albedo_color = Color.WHITE
		eye.material_override = white
		add_child(eye)
		var pupil := MeshInstance3D.new()
		var pm := SphereMesh.new()
		pm.radius = 0.04
		pm.height = 0.08
		pupil.mesh = pm
		pupil.position = Vector3(side*0.16,1.05,-0.445)
		add_child(pupil)
func _physics_process(delta: float) -> void:
	if not is_on_floor(): velocity.y -= gravity*delta
	if (Input.is_action_just_pressed("jump") or mobile_jump) and is_on_floor(): velocity.y = 5.0
	mobile_jump = false
	var k := Input.get_vector("move_left","move_right","move_forward","move_back")
	var v := mobile_move if mobile_move.length()>0.12 else k
	var d := Vector3(v.x,0,v.y).normalized()
	if d.length()>0.05:
		velocity.x=d.x*speed
		velocity.z=d.z*speed
		rotation.y=lerp_angle(rotation.y,atan2(-d.x,-d.z),delta*9.0)
	else:
		velocity.x=move_toward(velocity.x,0.0,speed*delta*4.0)
		velocity.z=move_toward(velocity.z,0.0,speed*delta*4.0)
	move_and_slide()
