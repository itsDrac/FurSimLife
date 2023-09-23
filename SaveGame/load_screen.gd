extends Panel

@export var load_button_path: PackedScene
@onready var game_grid = $VBoxContainer/PanelContainer/MarginContainer/VBoxC


var saved_files: Array

signal load_clicked(name: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	saved_files = SaveLoadMan.get_saved_files()
	for save_file in saved_files:
		add_load_games(save_file[0], save_file[1])

func add_load_games(file_name, modified_date):
	var load_btn: Button = load_button_path.instantiate()
	load_btn.get_node("./FN").text = file_name
	load_btn.get_node("./LM").text = Time.get_date_string_from_unix_time(modified_date)
	game_grid.add_child(load_btn)
	load_btn.pressed.connect(func(): load_btn_clicked(load_btn))

func load_btn_clicked(btn: Button):
	var game_name = btn.get_node("./FN").text
	load_clicked.emit(game_name)


func _on_cross_button_pressed():
	visible = false
