extends CharacterSprite
class_name CharacterMod

# will have to call this from Tags script on which part would be loaded.(Not everything have to be loaded)


var mod_sprites: Dictionary
var textures: Dictionary

signal change_frame

func _init():
	super()
	change_frame.connect(change_frame_of)
	load_human_sprites("Default")

static func get_mod_list():
	var mod_config = ConfigFile.new()
	mod_config.load("res://mods/config.cfg")
	if mod_config.has_section("Character"):
		return mod_config.get_section_keys("Character")
	

func load_sprites(folder_name):
	var mod_config = ConfigFile.new()
	mod_config.load("res://mods/%s/%s/%s/config.cfg"\
	%[folder_name, RACE.find_key(race), GENDER.find_key(gender)])
	if not mod_config.has_section("Mod_Sprites"):
		Utils.show_error_screen("Could not load mod sprites")

func load_human_sprites(folder_name):
	var config_file = ConfigFile.new()
	config_file.load("res://mods/"+folder_name+"/Human/config.cfg")
	if config_file.has_section("Human_mods"):
		for key in config_file.get_section_keys("Human_mods"):
			var sprite_name = config_file.get_value("Human_mods",key)
			var base_texture
			if sprite_name is Array:
				var a: Array 
				for i in sprite_name:
					var texture_path = "res://mods/"+folder_name+"/Human/"+i
#					a.append( _get_sptire(texture_path))
				base_texture = a
			else:
				var texture_path = "res://mods/"+folder_name+"/Human/"+sprite_name
#				base_texture = _get_sptire(texture_path)
			textures[key] = base_texture
		
func setup_human_sprites(tags,base_sprites):
	for key in textures:
		var s: Sprite2D = Sprite2D.new()
		s.centered = false
		s.name = key
		match key:
			"B_Bra","Bra", "Short_Sleeve_Shirt":
				var base_s = base_sprites["Base_Breast"]
				s.hframes = base_s.hframes
				s.vframes = base_s.vframes
				s.texture = textures[key]
				s.z_index = 0 if key == "B_Bra" else 1
				sprites[key] = s
				base_s.frame_changed.connect(func(): change_frame.emit(s, base_s.frame))
				base_s.add_child(s)
				change_frame.emit(s, base_s.frame)
			"Eye_Brow","Eye_Lashes","Eye_Iris":
				var base_s = base_sprites["Face_EyeBall"]
				s.hframes = base_s.hframes
				s.vframes = base_s.vframes
				s.texture = textures[key]
				sprites[key] = s
				base_s.frame_changed.connect(func(): change_frame.emit(s, base_s.frame))
				base_s.add_child(s)
				change_frame.emit(s, base_s.frame)
			"Hair_Backhair":
				var base_s = base_sprites["Base_Hair"]
				s.hframes = 6
				s.vframes = base_s.vframes
				s.texture = textures[key]
				s.z_index = -2
				s.frame_coords.x=tags.hair
				base_s.frame_changed.connect(func(): change_hair_view(base_s.frame_coords, s))
				sprites[key] = s
#				base_s.frame_changed.connect(func(): change_z_index(s))
				base_s.add_child(s)
#				change_frame.emit(s, base_s.frame)
			"Hair_Fronthair":
				var base_s = base_sprites["Base_Hair"]
				s.hframes = 4
				s.vframes = base_s.vframes
				s.texture = textures[key]
				s.frame_coords.x=tags.front_hair
				base_s.frame_changed.connect(func(): change_hair_view(base_s.frame_coords , s))
				sprites[key] = s
				base_s.add_child(s)
			"Underwear", "Pants", "Skirts":
				var base_s = base_sprites["Base_Butt"]
				s.hframes = base_s.hframes
				s.vframes = base_s.vframes
				s.texture = textures[key]
				sprites[key] = s
				base_s.frame_changed.connect(func(): change_frame.emit(s, base_s.frame))
				base_s.add_child(s)
				change_frame.emit(s, base_s.frame)

func change_frame_of(sp: Sprite2D, to: int):
	sp.frame = to

func change_z_index(sp: Sprite2D):
	match sp.frame_coords.y:
		2,5,8:
			sp.z_index = 0
		0,3,6:
			sp.z_index = -2

func change_hair_view(fc, s):
	if not s is Sprite2D:
		return
	s.frame_coords.y = fc.y
	if s.name == "Hair_Backhair":
		match fc.y:
			2,5,8:
				s.z_index = 0
			0,3,6:
				s.z_index = -2
	
	elif s.name == "Hair_Fronthair":
		match fc.y:
			2,5,8:
				s.z_index = -2
			0,3,6:
				s.z_index = 0
