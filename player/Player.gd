extends Node2D

var player
var player_sprite

signal hair_changed

func _ready():
	
	make_player()
	



func make_player():
#	player = CharacterStats.new()
#	CharacterStats.genrate_stats(player, "Drac", CharacterStats.TYPES.PLAYER)
#	player_sprite = CharacterSprite.new()
#	player_sprite.load_sprite(player.tag)
#	for sp in player_sprite.base_sprites:
#		var s = player_sprite.base_sprites[sp]
#		add_child(s)
#	print(player)
	player = CharacterMod.new()
	player.load_config("Default")
	player.genrate_stats("Drac",CharacterStats.TYPES.PLAYER)
#	char.add_tags()
#	char.setup_mod()
	for sprite in player.base_sprites:
		add_child(player.base_sprites[sprite])
	print(player)


func change_view(view: CharacterStats.VIEW):
	var row: int
	match player.gender:
		CharacterStats.GENDER.FEMALE:
			row = 0 + view
		CharacterStats.GENDER.MALE:
			row = 3 + view
		CharacterStats.GENDER.FUTA:
			row = 6 + view
	for sprite in player_sprite.base_sprites:
		var s: Sprite2D = player_sprite.base_sprites[sprite]
		s.frame_coords.y = row
