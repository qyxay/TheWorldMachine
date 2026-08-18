extends VBoxContainer

func _ready():
	do_color(self)

func do_color(node: Node):
	if node is CanvasItem:
		if node.get_meta("do_color", false):
			node.self_modulate = Setting.theme_color

	for child in node.get_children():
		do_color(child)
