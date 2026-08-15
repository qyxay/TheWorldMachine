extends Area2D

@export var texture:Texture2D
@export var icon_name:String

@onready var back_light: Sprite2D = $BackLight
@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label


var idle: BaseState
var hover: BaseState
var click: BaseState

var mouse:CharacterBody2D
var state:BaseState

func _ready() -> void:
	back_light.visible = false
	sprite.texture = texture
	label.text = icon_name
	
	idle = Setting.IconIdle.new()
	hover = Setting.IconHover.new()
	click = Setting.IconClick.new()

	idle.host = self
	hover.host = self
	click.host = self

	state = idle
	mouse = get_tree().root.get_node("Desktop/Mouse")

func _input(event:InputEvent):
	if event.is_action_pressed("mouse_left"):
		if state == hover:
			change_state(click)
		elif state == click:
			if mouse.hover_icon != self:
				change_state(idle)

func _process(delta: float) -> void:
	if state:
		state.update(delta)

func _on_body_entered(body: Node2D) -> void:
	if body == mouse:
		if state == idle:
			change_state(hover)

func _on_body_exited(body: Node2D) -> void:
	if body == mouse:
		if state == hover:
			change_state(idle)

func change_state(to_state:BaseState):
	if state == to_state:
		return
	state.exit()
	state = to_state
	state.host = self
	state.enter()
