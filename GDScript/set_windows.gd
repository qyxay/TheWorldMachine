extends VBoxContainer

var border = Setting.border
func _ready() -> void:
	set_border_color(self)

func set_border_color(node:Node):
	if node is CanvasItem:
		if node.get("offset_left") != null:
			node.offset_left = border
			node.offset_top = border
			node.offset_right = -border + 1
			# 为啥要+1我也不知道，反正不加就不对劲
			node.offset_bottom = -border
			
		if node.get_meta("do_color",false):
			node.self_modulate = Setting.theme_color
	for child in node.get_children():
		set_border_color(child)
