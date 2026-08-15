extends Area2D

@export var texture:Texture2D
@export var icon_name:String

@onready var back_light: Sprite2D = $BackLight
@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label

@onready var Idle: BaseState = $StateMachine/Idle
@onready var Hover: BaseState = $StateMachine/Hover
@onready var Click: BaseState = $StateMachine/Click


var mouse:CharacterBody2D
var state:BaseState

func _ready() -> void:
	back_light.visible = false
	sprite.texture = texture
	label.text = icon_name
	
	state = Idle
	mouse = get_tree().root.get_node("Desktop/Mouse")

func _input(event:InputEvent):
	if event.is_action_pressed("mouse_left"):
		if state == Hover:
			change_state(Click)
		elif state == Click:
			if mouse.is_in_icon:
				change_state(Hover)
			else:
				change_state(Idle)

func _physics_process(_delta: float) -> void:
	state.update(_delta)

func _on_body_entered(body: Node2D) -> void:
	if body == mouse:
		if state == Idle:
			change_state(Hover)

func _on_body_exited(body: Node2D) -> void:
	if body == mouse:
		if state == Hover:
			change_state(Idle)
			

func change_state(to_state:BaseState):
	state.exit()
	state = to_state
	state.host = self
	state.enter()
