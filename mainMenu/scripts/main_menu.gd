extends Control


@onready var mod = $Menu/Mod
@onready var settings = $Menu/Settings
@onready var new_game = $Menu/NewGame
@onready var continue_btn = $Menu/Continue
@onready var exit = $Menu/Exit

@onready var warning_screen = $WarningScreen
@onready var mod_screen = $ModScreen
@onready var setting_screen = $SettingScreen
@onready var loading_screen = $LoadingScreen

@export_file("*.tscn") var player_scene_path

# Called when the node enters the scene tree for the first time.
func _ready():
	mod.pressed.connect(func(): mod_screen.visible=true)
	settings.pressed.connect(func(): setting_screen.visible=true)
	new_game.pressed.connect(func(): warning_screen.visible=true)
	exit.pressed.connect(func(): Utils.quit_game())
	warning_screen.load_new_player.connect(load_new_player)
	check_save()

func check_save():
	var dir = DirAccess.open(SaveLoadMan.save_path)
	var saved_files = dir.get_files()
	if not saved_files.size():
		continue_btn.disabled = true
	pass

func load_new_player():
	loading_screen.load_scene(player_scene_path)

