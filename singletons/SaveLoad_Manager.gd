extends Node

const save_file = "Playerdata.tres"
const save_path = "res://SaveGame/"

signal save_game

func _ready():
	DirAccess.make_dir_absolute(save_path)
	save_game.connect(_on_save)

func _on_save():
	print_debug("On save function callled")
	

## Info to save for Player ##
#  1. Character

func _on_player_save(player_data: PlayerData):
	var err = ResourceSaver.save(player_data, save_path+save_file)
	if err == OK:
		print_debug("Player data saved.")

func _on_player_load() -> PlayerData:
	var res = ResourceLoader.load(save_path+save_file).duplicate(true)
	return res
