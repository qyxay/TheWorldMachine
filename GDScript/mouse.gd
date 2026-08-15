extends CharacterBody2D

@onready var mouse_click: AudioStreamPlayer = $MouseClick
@onready var mouse_un_click: AudioStreamPlayer = $MouseUnClick

var hover_icon:Node2D # 鼠标当前悬浮在的icon
var state:BaseState # 鼠标的状态

var idle:BaseState
var click:BaseState
var push:BaseState

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	var all_icons:Array[Node] = get_tree().get_nodes_in_group("icon_group")
	for icon in all_icons:
		icon.connect("body_entered",on_icon_body_entered.bind(icon))
		icon.connect("body_exited",on_icon_body_exited)
	
	idle = Setting.MouseIdle.new()
	click = Setting.MouseClick.new()
	push = Setting.MousePush.new()
	
	idle.host = self
	click.host = self
	push.host = self
	
	state = idle

func _physics_process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	if(state):
		state.update(_delta)

func _input(event:InputEvent):
	if event.is_action_pressed("mouse_left"):
		mouse_click.play()
	if event.is_action_released("mouse_left"):
		mouse_un_click.play()

func on_icon_body_entered(collider:Node2D,icon:Node2D):
	if collider == self:
		hover_icon = icon
		
func on_icon_body_exited(collider:Node2D):
	if collider == self:
		hover_icon = null

func change_state(to_state:BaseState):
	if state == to_state:
		return
	state.exit()
	state = to_state
	state.host = self
	state.enter()
