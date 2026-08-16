extends Node2D

const theme_color = Color("9664ffc0")

const IconClick = preload("uid://dgwrdau2qve7u")
const IconHover = preload("uid://b6igchd0h8abr")
const IconIdle = preload("uid://dvkwy8p6da1kv")

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
