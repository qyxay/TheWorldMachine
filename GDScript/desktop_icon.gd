extends Area2D

@export var texture:Texture2D
@export var icon_name:String

@onready var back_light: Sprite2D = $BackLight
@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label

var mouse:CharacterBody2D

func _ready() -> void:
	back_light.visible = false
	sprite.texture = texture
	label.text = icon_name
	
	mouse = get_tree().root.get_node("Desktop/Mouse")

func _physics_process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body == mouse:
		back_light.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body == mouse:
		back_light.visible = false
