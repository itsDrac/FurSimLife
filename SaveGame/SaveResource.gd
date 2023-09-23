class_name SaveRes
extends Resource

@export var G_player_name: StringName
@export var G_player_gender: CharacterStats.GENDER

@export var G_current_turn: int
@export var name: StringName
@export var G_team: Array[CharacterMod]

@export var inventory_items: Dictionary

func _init():
	G_player_name = G.player_name
	G_player_gender = G.player_gender
	G_current_turn = G.current_turn
	G_team = G.team

static func load_game(res: SaveRes):
	G.new_game = false
	G.player_name = res.G_player_name
	G.player_gender = res.G_player_gender
	G.team = res.G_team
	G.current_turn = res.G_current_turn
