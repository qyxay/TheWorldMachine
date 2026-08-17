extends "res://GDScript/desktop_icon.gd"

func _physics_process(_delta: float) -> void:
	if Setting.mouse_at_icon == self and Setting.is_double_click():
		get_tree().quit()
		
