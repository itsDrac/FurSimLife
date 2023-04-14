extends Control

@onready var quit_button = $PanelContainer/CenterContainer/VBoxContainer/Panel/QuitButton
@onready var play_button = $PanelContainer/CenterContainer/VBoxContainer/Panel/PlayButton
@export var player_scene: PackedScene

@onready var cross = $PanelContainer/CenterContainer/VBoxContainer/Label/TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	quit_button.pressed.connect(func(): Utils.quit_game())
	play_button.pressed.connect(func(): Utils.change_scene(get_parent_control(), player_scene.instantiate()))
	cross.pressed.connect(func(): visible = false)


