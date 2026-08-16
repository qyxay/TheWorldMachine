extends BaseState


func enter():
	sname = "idle"
	var MouseSprite:AnimatedSprite2D = host.get_node("MouseSprite")
	MouseSprite.play("idle")
	
func exit():
	pass
	
func update(_delta):
	if Setting.mouse_at_icon:
		host.change_state(host.click)
