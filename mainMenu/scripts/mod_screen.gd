extends Control

@onready var cross = $TextureButton

@onready var player_mod_btn = $Panel/ScrollContainer/MarginContainer/VBoxContainer/PlayerModContainer/PlayerModBtn

var player_mods: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	cross.pressed.connect(func(): visible = false)
	_update_player_mod_btn()
	

func _update_player_mod_btn():
	player_mods = CharacterMod.get_mod_list()
	print_debug(player_mods)
	player_mod_btn.item_selected.connect(_update_G_player_mod)
	for p in player_mods.keys():
		player_mod_btn.add_item(p)
	player_mod_btn.select(0)

func _update_G_player_mod(x):
	G.mod_player_selected= player_mods[player_mods.keys()[x]]
	print_debug(G.mod_player_selected)

