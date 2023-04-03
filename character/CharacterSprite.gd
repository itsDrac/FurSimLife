extends Resource
class_name CharacterSprite

var race_config
var sprites: Dictionary
var race: Dictionary

var butt_size: Dictionary
var breast_size: Dictionary
var genital: Dictionary
var testicle_size: Dictionary
var vaginal_orifices: Dictionary
var anus_orifices: Dictionary
var pergbelly: Dictionary
var eggpregbelly: Dictionary
var eggpregbelly_anal: Dictionary
var age: Dictionary
var piercing: Dictionary
var skin_color: Dictionary
var hair: Dictionary
var wearable: Dictionary
var front_hair: Dictionary

signal hair_changed (hair_type)
signal butt_size_changed (butt_type)

func _init():
	hair_changed.connect(change_hair)
	butt_size_changed.connect(change_butt_size)
	race_config = ConfigFile.new()
	race_config.load("res://character/sprites/config.cfg")
	if race_config.has_section("Race"):
		return
#		for r in race_config.get_section_keys("Race"):
#			match r:
#				"IS_HUMAN":
#					_load_base_sprites(race_config.get_value("Race", "IS_HUMAN"))
	pass


func _get_sptire(path) -> ImageTexture:
	var image = Image.load_from_file(path)
	var texture = ImageTexture.create_from_image(image)
	return texture

func _load_base_sprites(folder_name):
	var config_file = ConfigFile.new()
	config_file.load("res://character/sprites/"+folder_name+"/config.cfg")
	if config_file.has_section("Base_Sprites"):
		for key in config_file.get_section_keys("Base_Sprites"):
			var sprite_name = config_file.get_value("Base_Sprites",key)
			var texture_path = "res://character/sprites/"+folder_name+"/"+sprite_name
			var base_texture = _get_sptire(texture_path)
#			race[key] = base_texture
			match key:
				"Base_Torso","Base_Hair","Face_Iris","Face_EyeLashes","Face_EyeBrow","Face_EyeBall":
					race[key] = base_texture
				"Base_ButtSize1","Base_ButtSize2","Base_ButtSize3":
					butt_size[key] = base_texture
				"Hair_PonyTail1","Hair_PonyTail2","Hair_PonyTail3":
					hair[key] = base_texture
				"Base_Breast":
					breast_size[key] = base_texture
#				"Base_Torso":
#					var sprite_name = config_file.get_value("Base_Sprites","Base_Torso")
#					var texture_path = "res://character/sprites/"+folder_name+"/"+sprite_name
#					var base_texture = _get_sptire(texture_path)
#					race["base_torso"] = base_texture
#				"Base_Hair":
#					var sprite_name = config_file.get_value("Base_Sprites","Base_Torso")
#					var texture_path = "res://character/sprites/"+folder_name+"/"+sprite_name
#					var base_texture = _get_sptire(texture_path)
#					race["base_torso"] = base_texture

func load_sprite(tags: CharacterTag):
	
	match tags.race:
		CharacterTag.RACE.IS_HUMAN:
			_load_base_sprites(race_config.get_value("Race", "IS_HUMAN"))
			for texture in race:
				var sp = Sprite2D.new()
				sp.centered = false
				sp.texture = race[texture]
				sp.name = texture
				sp.hframes = 6
				sp.vframes = 9
				sprites[texture] = [sp, null]
	match tags.butt_size:
		CharacterTag.BUTT_SIZE.IS_BUTT_SIZE1:
			var sp = Sprite2D.new()
			sp.centered = false
			sp.texture = butt_size["Base_ButtSize1"]
			sp.name = "Base_ButtSize"
			sp.hframes = 6
			sp.vframes = 9
			sprites["Base_ButtSize"] = [sp, null]
		CharacterTag.BUTT_SIZE.IS_BUTT_SIZE2:
			var sp = Sprite2D.new()
			sp.centered = false
			sp.texture = butt_size["Base_ButtSize2"]
			sp.name = "Base_ButtSize"
			sp.hframes = 6
			sp.vframes = 9
			sprites["Base_ButtSize"] = [sp, null]
		CharacterTag.BUTT_SIZE.IS_BUTT_SIZE3:
			var sp = Sprite2D.new()
			sp.centered = false
			sp.texture = butt_size["Base_ButtSize3"]
			sp.name = "Base_ButtSize"
			sp.hframes = 6
			sp.vframes = 9
			sprites["Base_ButtSize"] = [sp, null]
	match tags.hair:
		CharacterTag.HAIR.HAS_PONYTAIL1:
			var sp = Sprite2D.new()
			sp.centered = false
			sp.texture = hair["Hair_PonyTail1"]
			sp.name = "Hair"
			sp.hframes = 6
			sp.vframes = 9
			sprites["Hair"] = [sp, "Base_Hair"]
		CharacterTag.HAIR.HAS_PONYTAIL2:
			var sp = Sprite2D.new()
			sp.centered = false
			sp.texture = hair["Hair_PonyTail2"]
			sp.name = "Hair"
			sp.hframes = 6
			sp.vframes = 9
			sprites["Hair"] = [sp, "Base_Hair"]
		CharacterTag.HAIR.HAS_PONYTAIL3:
			var sp = Sprite2D.new()
			sp.centered = false
			sp.texture = hair["Hair_PonyTail3"]
			sp.name = "Hair"
			sp.hframes = 6
			sp.vframes = 9
			sprites["Hair"] = [sp, "Base_Hair"]
	match tags.breast_size:
		_:
			var sp = Sprite2D.new()
			sp.centered = false
			sp.texture = breast_size["Base_Breast"]
			sp.name = "BreastSize"
			sp.hframes = 6
			sp.vframes = 9
			sprites["Base_Breast"] = [sp, "Base_Torso"]

#	return sprites

func change_hair(hair_type):
	if not sprites.has("Hair"):
		return
	print(sprites)
	var sp: Sprite2D = sprites["Hair"][0]
	print(sp)
	match hair_type:
		CharacterTag.HAIR.HAS_PONYTAIL1:
			sp.texture = hair["Hair_PonyTail1"]
		CharacterTag.HAIR.HAS_PONYTAIL2:
			sp.texture = hair["Hair_PonyTail2"]
		CharacterTag.HAIR.HAS_PONYTAIL3:
			sp.texture = hair["Hair_PonyTail3"]

func change_butt_size(butt_type):
	if not sprites.has("Base_ButtSize"):
		return
	var sp : Sprite2D = sprites["Base_ButtSize"][0]
	
	match butt_type:
		CharacterTag.HAIR.HAS_PONYTAIL1:
			sp.texture = butt_size["Base_ButtSize1"]
		CharacterTag.HAIR.HAS_PONYTAIL2:
			sp.texture = butt_size["Base_ButtSize2"]
		CharacterTag.HAIR.HAS_PONYTAIL3:
			sp.texture = butt_size["Base_ButtSize3"]


















