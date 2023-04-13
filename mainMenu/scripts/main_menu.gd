extends Control


@onready var mod = $Menu/Mod
@onready var settings = $Menu/Settings
@onready var new_game = $Menu/NewGame
@onready var exit = $Menu/Exit

@onready var warning_screen = $WarningScreen
@onready var mod_screen = $ModScreen
@onready var setting_screen = $SettingScreen


# Called when the node enters the scene tree for the first time.
func _ready():
	mod.pressed.connect(func(): mod_screen.visible=true)
	settings.pressed.connect(func(): setting_screen.visible=true)
	new_game.pressed.connect(func(): warning_screen.visible=true)
	exit.pressed.connect(func(): Utils.quit_game())

