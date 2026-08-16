extends CharacterBody2D

@onready var mouse_click: AudioStreamPlayer = $MouseClick
@onready var mouse_un_click: AudioStreamPlayer = $MouseUnClick
@onready var mouse_sprite: AnimatedSprite2D = $MouseSprite

var state:BaseState # 鼠标的状态

var idle:BaseState
var click:BaseState
var push:BaseState

func _ready() -> void:
	# Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	idle = Setting.MouseIdle.new()
	click = Setting.MouseClick.new()
	push = Setting.MousePush.new()
	
	idle.host = self
	click.host = self
	push.host = self
	
	change_state(idle)

func _physics_process(_delta: float) -> void:
	DisplayServer.cursor_set_custom_image(get_anim_current_texture())
	global_position = get_global_mouse_position()
	if(state):
		state.update(_delta)

func _input(event:InputEvent):
	if event.is_action_pressed("mouse_left"):
		mouse_click.play()
	if event.is_action_released("mouse_left"):
		mouse_un_click.play()

func change_state(to_state:BaseState):
	if state == to_state:
		return
	if state: state.exit()
	state = to_state
	state.host = self
	state.enter()

func get_anim_current_texture() -> Texture2D:
	var _name = mouse_sprite.animation
	var idx = mouse_sprite.frame
	return mouse_sprite.sprite_frames.get_frame_texture(_name, idx)
