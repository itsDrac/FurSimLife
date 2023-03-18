extends Control


@onready var mod = $Menu/Mod
@onready var settings = $Menu/Settings
@onready var mod_screen = $ModScreen
@onready var setting_screen = $SettingScreen
@onready var exit = $Menu/Exit


# Called when the node enters the scene tree for the first time.
func _ready():
	mod.pressed.connect(func(): mod_screen.visible=true)
	settings.pressed.connect(func(): setting_screen.visible=true)
	exit.pressed.connect(func(): get_tree().quit())

