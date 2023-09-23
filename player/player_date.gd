class_name PlayerData
extends Resource

@export var team: Array[CharacterMod]

func _init():
	SaveLoadMan.save_game.connect(_on_player_save)
	

func _on_player_save(res):
	pass
