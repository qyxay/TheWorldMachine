extends BaseState

var start_mouse_pos:Vector2
var start_icon_pos:Vector2
var offset_vector:Vector2
var target_pos:Vector2
func enter():
	sname = "drag"
	offset_vector = start_icon_pos - start_mouse_pos
	host.z_index = 1

func exit():
	host.global_position = host.round_pos(host.global_position)
	Setting.refresh_map()
	host.z_index = 0

func update(_delta):
	host.global_position = host.mouse.global_position + offset_vector
	if Input.is_action_just_released("mouse_left"):
		target_pos = host.round_pos(host.global_position)
		if Setting.pos_to_node.has(target_pos):
			var other:Area2D = Setting.pos_to_node[target_pos]
			other.get_node("BackLight").visible = false
			other.global_position = start_icon_pos
		Setting.mouse_at_icon = host
		host.change_state(host.hover)
		return
