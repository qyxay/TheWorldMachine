extends Area2D

@export var texture:Texture2D
@export var icon_name:String

@onready var back_light: Sprite2D = $BackLight
@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label


var idle: BaseState
var hover: BaseState
var click: BaseState
var drag: BaseState

var mouse:CharacterBody2D
var state:BaseState

func _ready() -> void:
	back_light.visible = false
	sprite.texture = texture
	label.text = icon_name
	
	idle = Setting.IconIdle.new()
	hover = Setting.IconHover.new()
	click = Setting.IconClick.new()
	drag = Setting.IconDrag.new()

	idle.host = self
	hover.host = self
	click.host = self
	drag.host = self

	change_state(idle)
	mouse = get_tree().root.get_node("Desktop/Mouse")
	
	global_position = round_pos(global_position)
	Setting.pos_to_node[global_position] = self

func _input(event:InputEvent):
	if event.is_action_pressed("mouse_left"):
		if state == hover:
			change_state(click)
		elif state == click:
			if Setting.mouse_at_icon != self:
				change_state(idle)

func _process(delta: float) -> void:
	# print(Setting.mouse_at_icon)
	if state:
		state.update(delta)

func change_state(to_state:BaseState):
	if state: state.exit()
	state = to_state
	state.enter()

func round_pos(pos:Vector2):
	var snap_x:float = clamp(round(pos.x / 300) * 300 + 100, -800, 700)
	var snap_y:float = clamp(round(pos.y / 200) * 200, -400, 200)
	var snap_pos:Vector2 = Vector2(snap_x, snap_y)
	return snap_pos

func _on_mouse_entered() -> void:
	Setting.mouse_at_icon = self

func _on_mouse_exited() -> void:
	if Setting.mouse_at_icon == self:
		Setting.mouse_at_icon = null
