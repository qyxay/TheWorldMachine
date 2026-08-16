extends BaseState


func enter():
	sname = "click"
	var MouseSprite:AnimatedSprite2D = host.get_node("MouseSprite")
	MouseSprite.play("click")
	
func exit():
	pass
	
func update(_delta):
	if Setting.mouse_at_icon == null:
		host.change_state(host.idle)
	elif Input.is_action_just_pressed("mouse_left"):
		host.change_state(host.push)
