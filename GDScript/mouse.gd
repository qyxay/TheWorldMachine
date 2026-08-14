extends CharacterBody2D

@onready var mouse_click: AudioStreamPlayer = $MouseClick
@onready var mouse_un_click: AudioStreamPlayer = $MouseUnClick

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _physics_process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func _input(event:InputEvent):
	if event.is_action_pressed("mouse_left"):
		mouse_click.play()
	if event.is_action_released("mouse_left"):
		mouse_un_click.play()
