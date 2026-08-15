extends BaseState


func enter():
	sname = "push"
	var MouseSprite:AnimatedSprite2D = host.get_node("MouseSprite")
	MouseSprite.play("push")
	
func exit():
	pass
	
func update(_delta):
	if Input.is_action_just_released("mouse_left"):
		host.change_state(host.click)
