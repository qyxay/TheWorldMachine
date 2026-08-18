extends VBoxContainer

# 你要设置的染色颜色
@export var tint_color: Color = Setting.theme_color

func _ready():
	# 递归遍历所有子节点
	apply_tint_recursive(self)

func apply_tint_recursive(node: Node):
	if node is CanvasItem:
		# 读取元数据do_tint，不存在就返回false
		var need_tint: bool = node.get_meta("do_color", false)
		if need_tint:
			node.self_modulate = tint_color
		else:
			node.self_modulate = Color(1,1,1,1) # 恢复原色

	# 递归处理所有子节点
	for child in node.get_children():
		apply_tint_recursive(child)
