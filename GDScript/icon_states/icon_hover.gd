extends BaseState

func enter():
	sname = "hover"
	
	host.back_light.visible = true
	
func exit():
	pass
	
func update(_delta):
	if Setting.mouse_at_icon != host:
		# 如果鼠标离开了当前图标，则转移到idle状态
		host.change_state(host.idle)
	elif Input.is_action_just_pressed("mouse_left"):
		# 如果鼠标在当前图标 且 点击左键，那么转移到click状态
		host.change_state(host.click)
		
