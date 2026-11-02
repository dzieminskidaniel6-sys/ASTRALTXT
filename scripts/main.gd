extends Node3D
const PlayerScript=preload("res://scripts/player.gd")
const ControlsScript=preload("res://scripts/mobile_controls.gd")
var player:CharacterBody3D
var quest:Label
var count:=0
func mat(c:Color)->StandardMaterial3D:
	var m:=StandardMaterial3D.new()
	m.albedo_color=c
	return m
func box(parent:Node3D,size:Vector3,pos:Vector3,color:Color)->MeshInstance3D:
	var n:=MeshInstance3D.new()
	var b:=BoxMesh.new()
	b.size=size
	n.mesh=b
	n.position=pos
	n.material_override=mat(color)
	parent.add_child(n)
	return n
func _ready()->void:
	var floor:=StaticBody3D.new()
	add_child(floor)
	box(floor,Vector3(140,1,140),Vector3(0,-0.55,0),Color(0.25,0.48,0.19))
	var col:=CollisionShape3D.new()
	var fs:=BoxShape3D.new()
	fs.size=Vector3(140,1,140)
	col.shape=fs
	col.position.y=-0.55
	floor.add_child(col)
	box(self,Vector3(8,0.04,130),Vector3.ZERO,Color(0.43,0.32,0.2))
	var homes=[Vector3(-10,0,-9),Vector3(11,0,-12),Vector3(-13,0,13),Vector3(14,0,13)]
	for i in homes.size():
		var h:Vector3=homes[i]
		box(self,Vector3(5,3.2,4),h+Vector3(0,1.6,0),[Color(0.83,0.67,0.42),Color(0.65,0.72,0.8),Color(0.8,0.48,0.4),Color(0.7,0.75,0.52)][i])
		box(self,Vector3(5.8,0.65,4.8),h+Vector3(0,3.5,0),Color(0.35,0.12,0.1))
	for i in range(24):
		var x:=float((i*19)%57-28)
		var z:=float((i*31)%61-30)
		if abs(x)<6: continue
		box(self,Vector3(0.4,2,0.4),Vector3(x,1,z),Color(0.3,0.18,0.08))
		var crown:=MeshInstance3D.new()
		var sm:=SphereMesh.new()
		sm.radius=1.25
		sm.height=2.5
		crown.mesh=sm
		crown.position=Vector3(x,2.7,z)
		crown.material_override=mat(Color(0.12,0.38,0.12))
		add_child(crown)
	for i in range(8):
		var item:=Area3D.new()
		item.position=Vector3(float((i*13)%23-11),0.5,float((i*17)%29-14))
		var visual:=MeshInstance3D.new()
		var bm:=SphereMesh.new()
		bm.radius=0.3
		bm.height=0.45
		visual.mesh=bm
		visual.material_override=mat(Color(0.95,0.67,0.25))
		item.add_child(visual)
		var hit:=CollisionShape3D.new()
		var hs:=SphereShape3D.new()
		hs.radius=0.75
		hit.shape=hs
		item.add_child(hit)
		item.body_entered.connect(_collect.bind(item))
		add_child(item)
	var sun:=DirectionalLight3D.new()
	sun.rotation_degrees=Vector3(-52,-25,0)
	add_child(sun)
	var player_env:=WorldEnvironment.new()
	var env:=Environment.new()
	env.background_mode=Environment.BG_SKY
	env.sky=Sky.new()
	env.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color=Color(0.7,0.75,0.85)
	player_env.environment=env
	add_child(player_env)
	player=CharacterBody3D.new()
	player.name="Player"
	player.set_script(PlayerScript)
	player.position=Vector3(0,0.2,5)
	var pc:=CollisionShape3D.new()
	var capsule:=CapsuleShape3D.new()
	capsule.radius=0.42
	capsule.height=1.5
	pc.shape=capsule
	pc.position.y=0.75
	player.add_child(pc)
	add_child(player)
	var pivot:=Node3D.new()
	pivot.position.y=1.5
	player.add_child(pivot)
	var cam:=Camera3D.new()
	cam.position=Vector3(0,2.5,7)
	pivot.add_child(cam)
	cam.look_at(Vector3(0,1,0))
	cam.current=true
	var controls=ControlsScript.new()
	add_child(controls)
	controls.move_changed.connect(func(v:Vector2): player.mobile_move=v)
	controls.jump_requested.connect(func(): player.mobile_jump=true)
	var title:=Label.new()
	title.text="WIEŚ.EXE  •  BETA"
	title.position=Vector2(20,16)
	title.add_theme_font_size_override("font_size",24)
	controls.add_child(title)
	quest=Label.new()
	quest.text="ZADANIE: Zbierz 8 bułek dla babci  |  0/8"
	quest.position=Vector2(20,52)
	quest.add_theme_font_size_override("font_size",18)
	controls.add_child(quest)
func _collect(body:Node3D,item:Area3D)->void:
	if body!=player:return
	count+=1
	item.queue_free()
	quest.text="Zebrane bułki: %d/8"%count
	if count>=8:quest.text="ZADANIE UKOŃCZONE! Babcia jest dumna 🍞"
