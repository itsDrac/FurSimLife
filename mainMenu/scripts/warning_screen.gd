extends Control

@onready var quit_button = $PanelContainer/CenterContainer/VBoxContainer/Panel/QuitButton
@onready var play_button = $PanelContainer/CenterContainer/VBoxContainer/Panel/PlayButton

# Called when the node enters the scene tree for the first time.
func _ready():
	quit_button.pressed.connect(func(): Utils.quit_game())


