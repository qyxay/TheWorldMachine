extends Node2D

const theme_color = Color("9664ffc0")

const IconClick = preload("uid://dgwrdau2qve7u")
const IconHover = preload("uid://b6igchd0h8abr")
const IconIdle = preload("uid://dvkwy8p6da1kv")
const IconDrag = preload("uid://b10rofoe618tm")

const MouseClick = preload("uid://co14gedib7fea")
const MouseIdle = preload("uid://blpr1pvkcbdjr")
const MousePush = preload("uid://br4a7nxmnjk3y")

var pos_to_node: Dictionary = {}
func refresh_map():
	pos_to_node.clear()
	var all_icons = get_tree().get_nodes_in_group("icon_group")
	for icon in all_icons:
		if not icon.is_inside_tree():
			continue
		var p = icon.round_pos(icon.position)
		if not pos_to_node.has(p):
			pos_to_node[p] = icon
		else:
			print("Errow: ",p,"exists icon！")
func remove_pos(pos:Vector2):
	if pos_to_node.has(pos):
		pos_to_node.erase(pos)

var mouse_at_icon:Area2D

var last_click_time:float = 0.0
const DOUBLE_CLICK_THRESHOLD:float = 300 #ms
func is_double_click() -> bool:
	if Input.is_action_just_pressed("mouse_left"):
		var now: float = Time.get_ticks_msec()
		var is_double: bool = now - last_click_time <= DOUBLE_CLICK_THRESHOLD
		if !is_double:
			last_click_time = now
		return is_double
	return false
