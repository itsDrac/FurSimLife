class_name Character extends Node2D

var char
var sprites

#func make_player(name: StringName, args:Array = []):
#	char = CharacterStats.new()
#	CharacterStats.genrate_stats(char, name, CharacterStats.TYPES.PLAYER)
#	sprites = CharacterSprite.new()
#	sprites.load_sprite(char.tag)
#	for sp in sprites.base_sprites:
#		var s = sprites.base_sprites[sp]
#		self.add_child(s)
#
#
#func change_view(view: CharacterStats.VIEW):
#	var row: int
#	match char.gender:
#		CharacterStats.GENDERS.FEMALE:
#			row = 0 + view
#		CharacterStats.GENDERS.MALE:
#			row = 3 + view
#		CharacterStats.GENDERS.FUTA:
#			row = 6 + view
#	for sprite in sprites.base_sprites:
#		var s: Sprite2D = sprites.base_sprites[sprite]
#		s.frame_coords.y = row


