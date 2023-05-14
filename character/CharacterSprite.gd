extends CharacterTag
class_name CharacterSprite

var race_config
var base_sprites: Dictionary
var sprites: Dictionary
var mod: CharacterMod

signal breast_size_changed (breast_type)
signal butt_size_changed (butt_type)
signal base_breast_view_changed (sp)

func _init():
	breast_size_changed.connect(change_breast)
	butt_size_changed.connect(change_butt_size)
	base_breast_view_changed.connect(change_z_index)
	race_config = ConfigFile.new()
	var err = race_config.load("res://character/sprites/config.cfg")
	print_debug(race_config.get_sections())
	if err != OK:
		Utils.show_error_screen("Could not load base sprite")
	
	if race_config.has_section("Race"):
		print_debug(race_config.get_value("Race", "IS_HUMAN"))
	


func _get_sptire(path) -> CompressedTexture2D:
	var image = load(path)
#	var texture = ImageTexture.create_from_image(image)
	return image

func _load_base_sprites(folder_name: StringName):
	var config_file = ConfigFile.new()
	config_file.load("res://character/sprites/"+folder_name+"/config.cfg")
	if config_file.has_section("Base_Sprites"):
		for key in config_file.get_section_keys("Base_Sprites"):
			var sprite_name = config_file.get_value("Base_Sprites",key)
			var texture_path = "res://character/sprites/"+folder_name+"/"+sprite_name
			var base_texture = _get_sptire(texture_path)
			sprites[key] = base_texture

func _setup_human(tags):
	for texture in sprites:
		var sp: Sprite2D = Sprite2D.new()
		sp.centered = false
		match texture:
			"Base_Torso":
				sp.texture = sprites[texture]
				sp.name = texture
				sp.hframes = 1
				sp.vframes = 9
				base_sprites[texture] = sp
			"Base_Hair":
				sp.texture = sprites[texture]
				sp.name = texture
				sp.hframes = 1
				sp.vframes = 9
				sp.z_index = 1
				base_sprites[texture] = sp
			"Face_EyeBall":
				sp.texture = sprites[texture]
				sp.name = texture
				sp.hframes = 1
				sp.vframes = 9
				base_sprites[texture] = sp
			"Base_Butt":
				sp.texture = sprites[texture]
				sp.name = "Base_Butt"
				sp.hframes = 3
				sp.vframes = 9
				base_sprites[texture] = sp
				butt_size_changed.emit(tags.butt_size)
			"Base_Breast":
				sp.texture = sprites[texture]
				sp.name = texture
				sp.hframes = 6
				sp.vframes = 9
				sp.z_index = 1 # -1 if back view.
				sp.frame_changed.connect(func(): base_breast_view_changed.emit(sp))
				base_sprites[texture] = sp
				breast_size_changed.emit(tags.breast_size)
	

func load_sprite(tags: CharacterTag, mod_name="Default"):
	match tags.race:
		CharacterTag.RACE.IS_HUMAN:
			_load_base_sprites(race_config.get_value("Race", "IS_HUMAN"))
			_setup_human(tags)
			mod = CharacterMod.new()
			mod.load_human_sprites(mod_name)
			mod.setup_human_sprites(tags, base_sprites)
	

func change_breast(breast_type):
	if not base_sprites.has("Base_Breast"):
		return
	var sp : Sprite2D = base_sprites["Base_Breast"]
#	for s in sp.get_children():
#		print_debug(s)
#		s.frame_coords.x = breast_type
	sp.frame_coords.x = breast_type

func change_butt_size(butt_type):
	if not base_sprites.has("Base_Butt"):
		return
	var sp : Sprite2D = base_sprites["Base_Butt"]
	sp.frame_coords.x = butt_type


func change_z_index(sp: Sprite2D):
	match sp.frame_coords.y:
		2,5,8:
			sp.z_index = -1
		0,3,6:
			sp.z_index = 1










