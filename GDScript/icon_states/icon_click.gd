extends BaseState

func enter():
	sname = "click"
	set_modulate_v(1.0)

func exit():
	set_modulate_v(0.6)
	
func update(_delta):
	if Input.is_action_just_pressed("mouse_left"):
		if Setting.mouse_at_icon != host:
			# 当前图标高亮时，如果鼠标离开这个图标 并 单击左键，那么就回到默认idle状态
			host.change_state(host.idle)
	
func set_modulate_v(to_v:float):
	var c = host.back_light.modulate
	c.v = to_v
	host.back_light.modulate = c
