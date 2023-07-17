extends Control

@onready var quit_button = $PanelContainer/CenterContainer/VBoxContainer/Panel/QuitButton
@onready var play_button = $PanelContainer/CenterContainer/VBoxContainer/Panel/PlayButton
@export var player_scene: PackedScene

@onready var cross = $PanelContainer/CenterContainer/VBoxContainer/Label/TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	quit_button.pressed.connect(func(): Utils.quit_game())
	play_button.pressed.connect(play_btn_clicked)
	cross.pressed.connect(func(): visible = false)

func play_btn_clicked():
	var name: StringName = $PanelContainer/CenterContainer/VBoxContainer/LineEdit.text
	name = name.c_unescape().strip_edges()
	if name.is_empty():
		$PanelContainer/CenterContainer/VBoxContainer/ErrorLabel.visible = true
		return
	$PanelContainer/CenterContainer/VBoxContainer/ErrorLabel.visible = false
	G.player_name = name
	Utils.change_scene(get_parent_control(), player_scene.instantiate())
