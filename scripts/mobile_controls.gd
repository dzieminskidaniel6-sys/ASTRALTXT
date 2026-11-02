extends CanvasLayer
signal move_changed(value:Vector2)
signal jump_requested
var center:=Vector2.ZERO
var radius:=72.0
var knob:=Vector2.ZERO
var finger:=-1
var jump_area:=Rect2()
func _ready()->void:
	get_viewport().size_changed.connect(_layout)
	_layout()
func _layout()->void:
	var s=get_viewport().get_visible_rect().size
	center=Vector2(112,s.y-112)
	jump_area=Rect2(s.x-150,s.y-145,112,112)
	queue_redraw()
func _draw()->void:
	draw_circle(center,radius,Color(0,0,0,0.35))
	draw_arc(center,radius,0,TAU,48,Color.WHITE,3)
	draw_circle(center+knob,32,Color(1,1,1,0.6))
	draw_circle(jump_area.get_center(),56,Color(0.1,0.55,0.2,0.75))
	draw_arc(jump_area.get_center(),56,0,TAU,48,Color.WHITE,3)
	draw_string(ThemeDB.fallback_font,jump_area.get_center()+Vector2(-25,8),"SKOK",HORIZONTAL_ALIGNMENT_LEFT,-1,20,Color.WHITE)
func _input(e:InputEvent)->void:
	if e is InputEventScreenTouch:
		if e.pressed:
			if e.position.distance_to(center)<125 and finger==-1:
				finger=e.index
				_update_stick(e.position)
			elif jump_area.has_point(e.position):jump_requested.emit()
		elif e.index==finger:
			finger=-1
			knob=Vector2.ZERO
			move_changed.emit(Vector2.ZERO)
			queue_redraw()
	elif e is InputEventScreenDrag and e.index==finger:_update_stick(e.position)
func _update_stick(pos:Vector2)->void:
	var d=pos-center
	if d.length()>radius:d=d.normalized()*radius
	knob=d
	move_changed.emit(Vector2(d.x/radius,d.y/radius))
	queue_redraw()
