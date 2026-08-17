extends BaseState

var start_mouse_pos:Vector2
var start_icon_pos:Vector2
func enter():
	sname = "click"
	set_modulate_v(1.0)
	
	start_mouse_pos = Vector2(0,0)
	start_icon_pos = Vector2(0,0)

func exit():
	set_modulate_v(0.6)
	
func update(_delta):
	if Input.is_action_just_pressed("mouse_left") and Setting.mouse_at_icon != host:
		# 当前图标高亮时，如果鼠标离开这个图标 并 单击左键，那么就回到默认idle状态
		host.change_state(host.idle)
	if Input.is_action_pressed("mouse_left"):
		if ! start_mouse_pos:
			# 如果鼠标左键 且 start_mouse_pos没有值，即这是按下鼠标的第一帧
			# 那么设置鼠标开始移动的位置
			start_mouse_pos = host.mouse.global_position
			start_icon_pos = host.global_position
		else:
			# 如果鼠标左键 且 不是第一帧，那么判断移动幅度是否超过了防误触限度
			var move_dis_sqr:float = start_mouse_pos.distance_squared_to(host.mouse.global_position)
			if move_dis_sqr >= 900:
				host.drag.start_mouse_pos = start_mouse_pos
				host.drag.start_icon_pos = start_icon_pos
				host.change_state(host.drag)
				
	if Input.is_action_just_released("mouse_left") and Setting.mouse_at_icon == host:
		# 如果松开左键 且 鼠标还在当前图标，那么重置“开始按鼠标的位置”变量为0向量
		start_mouse_pos = Vector2(0,0)
	
func set_modulate_v(to_v:float):
	var c = host.back_light.modulate
	c.v = to_v
	host.back_light.modulate = c
