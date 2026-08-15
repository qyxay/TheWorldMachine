extends CharacterBody2D

@onready var mouse_click: AudioStreamPlayer = $MouseClick
@onready var mouse_un_click: AudioStreamPlayer = $MouseUnClick

var is_in_icon:bool = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	var all_icons:Array[Node] = get_tree().get_nodes_in_group("icon_group")
	for _icon in all_icons:
		_icon.connect("body_entered",on_icon_body_entered)
		_icon.connect("body_exited",on_icon_body_exited)

func _physics_process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func _input(event:InputEvent):
	if event.is_action_pressed("mouse_left"):
		mouse_click.play()
	if event.is_action_released("mouse_left"):
		mouse_un_click.play()

func on_icon_body_entered(body:Node2D):
	if body == self:
		is_in_icon = true
		
func on_icon_body_exited(body:Node2D):
	if body == self:
		is_in_icon = false
