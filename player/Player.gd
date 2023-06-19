extends Node2D

@onready var char: CharacterMod

func _ready():
	
	make_player("Drac",CharacterStats.TYPES.PLAYER)
	print_debug(char)



func make_player(char_name: StringName, type: CharacterStats.TYPES):
	char = CharacterMod.new()
	char.genrate_stats(char_name,type)
	char.load_config(G.mod_player_selected)
	char.add_base_mod()
	char.add_tags()
#	char.setup_mod()
	for sprite in char.base_sprites:
		add_child(char.base_sprites[sprite])
	
	return char

