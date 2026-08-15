extends BaseState

func enter():
	sname = "click"
	set_modulate_v(1.0)

func exit():
	set_modulate_v(0.6)
	
func update(_delta):
	pass
	
func set_modulate_v(to_v:float):
	var c = host.back_light.modulate
	c.v = to_v
	host.back_light.modulate = c
