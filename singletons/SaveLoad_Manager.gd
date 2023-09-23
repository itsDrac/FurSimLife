extends Node

const save_file = "%s.tres"
const save_path = "res://SaveGame/games/"
var save_folder: DirAccess = DirAccess.open(save_path)
var total_saved_files := 0

@onready var save_scene_path = preload("res://SaveGame/save_screen.tscn")
@onready var load_screen_path = preload("res://SaveGame/load_screen.tscn")
var save_screen: Control
var load_screen: Control

var load_res: SaveRes

signal save_game(res: Resource)
signal load_game(res: Resource)

func _ready():
	save_screen = save_scene_path.instantiate()
	save_screen.visible = false
	save_screen.clicked_save.connect(_on_save_game)
	load_screen = load_screen_path.instantiate()
	load_screen.visible = false
	load_screen.load_clicked.connect(_on_load_game)
	DirAccess.make_dir_absolute(save_path)
	total_saved_files = save_folder.get_files().size()
#	save_game.connect(_on_save)
	

func _on_save():
	print_debug("On save function callled")
	

func get_saved_files():
	var saved_files: Array[Array]
	for save_file in save_folder.get_files():
		saved_files.append(
			[save_file.trim_suffix(".tres"),
		FileAccess.get_modified_time(save_path+save_file)]
		)
	return saved_files

## Info to save for Player ##
#  1. Character

func _on_save_game(save_name):
	var res = SaveRes.new()
	save_game.emit(res)
	var err = ResourceSaver.save(res, save_path+save_file%save_name)
	if err == OK:
		print_debug("Player data saved.")
		save_screen.visible = false

func _on_load_game(game_name):
	var res = ResourceLoader.load(save_path+save_file%game_name).duplicate(true)
	SaveRes.load_game(res)
	load_game.emit(res)
	load_res = res
	G.load_player.emit()
	

func _on_player_save(player_data: PlayerData):
	var err = ResourceSaver.save(player_data, save_path+save_file%save_folder.get_files().size())
	if err == OK:
		print_debug("Player data saved.")

func _on_player_load() -> PlayerData:
	var res = ResourceLoader.load(save_path+save_file).duplicate(true)
	return res
