extends Control

@onready var window_mode: OptionButton = $Panel/CenterContainer/GridContainer/WindowMode
@onready var window_res: OptionButton = $Panel/CenterContainer/GridContainer/WindowRes
@onready var cross = $TextureButton
@onready var _window: Window = get_window()

const resolution = {
	"3840 x 2160": Vector2i(3840, 2160),
	"2560 x 1440": Vector2i(2560, 1440),
	"1920 x 1080": Vector2i(1920, 1080),
	"1600 x 900": Vector2i(1600, 900),
	"1280 x 720": Vector2i(1280, 720),
	"960 x 540": Vector2i(960, 540)
}

# Called when the node enters the scene tree for the first time.
func _ready():
	window_mode.item_selected.connect(_window_mode_selected)
	setup_window_mode()
	window_res.item_selected.connect(_window_res_selected)
	setup_window_res()
	var cres = _window.size
	window_res.selected = resolution.values().find(cres)
	cross.pressed.connect(func(): visible = false)
	
#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
#	get_tree().reload_current_scene()

func setup_window_mode():
	var options = ["window", "fullscreen"]
	for o in options:
		window_mode.add_item(o)
	

func setup_window_res():
	for r in resolution:
		window_res.add_item(r)

func _window_mode_selected(i):
	if i == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		window_res.visible = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		window_res.visible = false
#		Window.borderless = false

func _window_res_selected(i):
	var res = window_res.get_item_text(window_res.get_item_index(i))
	_window.size = resolution[res]
	
