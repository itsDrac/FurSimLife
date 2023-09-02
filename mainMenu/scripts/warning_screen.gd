extends Control

@onready var quit_button = $PanelContainer/CenterContainer/VBoxContainer/Panel/QuitButton
@onready var play_button = $PanelContainer/CenterContainer/VBoxContainer/Panel/PlayButton
#@export var player_scene: PackedScene
@onready var gender_option = $PanelContainer/CenterContainer/VBoxContainer/HBoxContainer/OptionButton

@onready var cross = $PanelContainer/CenterContainer/VBoxContainer/Label/TextureButton

signal load_new_player

# Called when the node enters the scene tree for the first time.
func _ready():
	quit_button.pressed.connect(func(): Utils.quit_game())
	play_button.pressed.connect(play_btn_clicked)
	cross.pressed.connect(func(): visible = false)

func play_btn_clicked():
	var name: StringName = $PanelContainer/CenterContainer/VBoxContainer/HBoxContainer/LineEdit.text
	name = name.c_unescape().strip_edges()
	var gender = gender_option.get_selected_id()
	if name.is_empty() or gender == -1:
		$PanelContainer/CenterContainer/VBoxContainer/ErrorLabel.visible = true
		return
	$PanelContainer/CenterContainer/VBoxContainer/ErrorLabel.visible = false
	G.player_name = name
	G.player_gender = gender
#	Utils.change_scene(get_parent_control(), player_scene.instantiate())
	load_new_player.emit()
