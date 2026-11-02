extends Node3D

const PlayerScript = preload("res://scripts/player.gd")
var player: CharacterBody3D

func _ready() -> void:
	_build_world()
	_spawn_player()
	_build_hud()

func _material(color: Color) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = color
	return m

func _box(parent: Node3D, size: Vector3, pos: Vector3, color: Color) -> MeshInstance3D:
	var node := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = size
	node.mesh = mesh
	node.position = pos
	node.material_override = _material(color)
	parent.add_child(node)
	return node

func _build_world() -> void:
	var ground := StaticBody3D.new()
	add_child(ground)
	_box(ground, Vector3(100, 1, 100), Vector3(0, -0.55, 0), Color(0.25, 0.48, 0.19))
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = Vector3(100, 1, 100)
	collision.shape = shape
	collision.position.y = -0.55
	ground.add_child(collision)
	_box(self, Vector3(8, 0.03, 100), Vector3(0, 0.0, 0), Color(0.43, 0.32, 0.2))
	var positions := [Vector3(-9, 0, -8), Vector3(10, 0, -13), Vector3(-12, 0, 14), Vector3(13, 0, 12)]
	var house_colors := [Color(0.83,0.67,0.42), Color(0.65,0.72,0.8), Color(0.8,0.48,0.4), Color(0.7,0.75,0.52)]
	for i in positions.size():
		var p: Vector3 = positions[i]
		_box(self, Vector3(5, 3.2, 4), p + Vector3(0, 1.6, 0), house_colors[i])
		_box(self, Vector3(5.8, 0.65, 4.8), p + Vector3(0, 3.5, 0), Color(0.35, 0.12, 0.1))
		_box(self, Vector3(0.9, 1.7, 0.12), p + Vector3(0, 0.85, -2.06), Color(0.25, 0.14, 0.08))
	for i in range(22):
		var x := float((i * 17) % 43 - 21)
		var z := float((i * 29) % 45 - 22)
		if abs(x) < 5.0: continue
		_box(self, Vector3(0.45, 2.0, 0.45), Vector3(x, 1.0, z), Color(0.3,0.18,0.08))
		var crown := MeshInstance3D.new()
		var sphere := SphereMesh.new()
		sphere.radius = 1.35
		sphere.height = 2.7
		crown.mesh = sphere
		crown.position = Vector3(x, 2.8, z)
		crown.material_override = _material(Color(0.12, 0.38, 0.12))
		add_child(crown)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-52, -25, 0)
	sun.light_energy = 1.2
	add_child(sun)
	var env := WorldEnvironment.new()
	var e := Environment.new()
	e.background_mode = Environment.BG_SKY
	e.sky = Sky.new()
	e.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	e.ambient_light_color = Color(0.65, 0.72, 0.85)
	e.ambient_light_energy = 0.7
	env.environment = e
	add_child(env)

func _spawn_player() -> void:
	player = CharacterBody3D.new()
	player.set_script(PlayerScript)
	player.position = Vector3(0, 0.2, 5)
	var shape_node := CollisionShape3D.new()
	var capsule := CapsuleShape3D.new()
	capsule.radius = 0.48
	capsule.height = 1.45
	shape_node.shape = capsule
	shape_node.position.y = 0.75
	player.add_child(shape_node)
	add_child(player)
	var camera := Camera3D.new()
	camera.position = Vector3(0, 4.0, 8.0)
	camera.look_at_from_position(camera.position, Vector3(0, 1, 0))
	player.add_child(camera)
	camera.current = true

func _build_hud() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var label := Label.new()
	label.text = "WIES.EXE  |  WASD: ruch  |  SPACJA: skok\nZnajdź sens życia. Powodzenia."
	label.position = Vector2(18, 16)
	label.add_theme_font_size_override("font_size", 20)
	label.add_theme_color_override("font_color", Color.WHITE)
	layer.add_child(label)
