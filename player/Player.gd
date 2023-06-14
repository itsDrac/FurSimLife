extends Node2D

var player

func _ready():
	
	player = make_player("Drac",CharacterStats.TYPES.PLAYER)
	



func make_player(char_name: StringName, type: CharacterStats.TYPES):
	var char = CharacterMod.new()
	char.genrate_stats(char_name,type)
	char.load_config(G.mod_player_selected)
	char.add_base_mod()
	char.add_tags()
#	char.setup_mod()
	for sprite in char.base_sprites:
		add_child(char.base_sprites[sprite])
	print_debug(char)
	
	return char

