extends Node

var mod_player_selected: StringName = "Default"
var player_name: StringName = "Drac"
var player_gender: CharacterStats.GENDER = CharacterStats.GENDER.MALE
var current_char: Character

var current_turn: int = 0:
	get: return current_turn
	set(val):
		current_turn = val
		current_turn_changed.emit()

signal current_turn_changed
