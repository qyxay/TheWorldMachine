extends BaseState


func enter():
	sname = "idle"
	
	host.back_light.visible = false
	
func exit():
	pass
	
func update(_delta):
	if Setting.mouse_at_icon == host:
		# 如果鼠标在当前icon上，则icon转移到hover状态
		host.change_state(host.hover)
