extends CharacterSprite
class_name CharacterMod

# will have to call this from Tags script on which part would be loaded.(Not everything have to be loaded)


var mod_textures: Dictionary
var mod_sections: Array
var mod_config: ConfigFile
var mod_folder_name: StringName # first set the value for the selected mod

signal change_frame

func _init():
	super()
	change_frame.connect(change_frame_of)
	upper_body_wearable.item_added.connect(func(): print_debug(upper_body_wearable.last_added))
#	upper_body_wearable_changed.connect(update_upper_body_wearable)
#	view_changed.connect(update_mod_view)
#	load_human_sprites("Default")

static func get_mod_list():
	var mods: Dictionary
	var config = ConfigFile.new()
	config.load("res://mods/config.cfg")
	if config.has_section("Mods"):
		for key in config.get_section_keys("Mods"):
			var value = config.get_value("Mods", key)
			mods[key] = value
	return mods

func load_config(folder_name):
	mod_folder_name = folder_name
	mod_config = ConfigFile.new()
	mod_config.load("res://mods/%s/%s/%s/config.cfg"\
	%[mod_folder_name, RACE.find_key(race), GENDER.find_key(gender)])
	mod_sections = mod_config.get_sections()
	print_debug(mod_sections)
#	return mc
#	if not mod_config.has_section("Mod_Sprites"):
#		Utils.show_error_screen("Could not load mod sprites")
#	for key in mod_config.get_section_keys("Mod_Sprites"):
#		var sprite_name = mod_config.get_value("Mod_Sprites",key)
#		var texture_path = "res://mods/%s/%s/%s/%s"\
#			%[mod_folder_name, RACE.find_key(race), GENDER.find_key(gender), sprite_name]
#		var base_texture = load(texture_path)
#		mod_textures[key] = base_texture

func load_sprite(file_name) -> Sprite2D:
	if file_name == "":
		Utils.show_error_screen("Unable to load selected mod.")
	var s = Sprite2D.new()
	var path = "res://mods/%s/%s/%s/%s"\
	%[mod_folder_name, RACE.find_key(race), GENDER.find_key(gender), file_name]
	s.texture = load(path)
	return s

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

func setup_mod(name="Default"):
	print_debug("here")
#	setup_sprite()
	mod_folder_name = name
	upper_body_wearable_changed.connect(update_upper_body_wearable)
	upper_body_wearable.item_added.connect(func(): print_debug("called."))
	lower_body_wearable_changed.connect(update_lower_body_wearable)
#	mod_config = load_config(mod_folder_name)
	upper_body_wearable_changed.emit()
	lower_body_wearable_changed.emit()
#	print(mod_textures)

func update_upper_body_wearable():
	print_debug("upper body signal connected")
	for parent_name in ["Base_Torso","Base_ArmBackSide","Base_ArmLowerSide","Base_ArmUpperSide", "Base_Breast"]:
		if base_sprites.has(parent_name):
			var child_node = base_sprites[parent_name].get_children()
			for cn in child_node: cn.queue_free()
	print_debug(UPPER_BODY_WEARABLE.find_key(upper_body_wearable))
	print_debug(mod_config.get_sections().has(UPPER_BODY_WEARABLE.find_key(upper_body_wearable)))
	# Till above all the childs are removed from base sprites
	if not UPPER_BODY_WEARABLE.find_key(upper_body_wearable) in mod_config.get_sections():
		Utils.show_error_screen("Unable to load selected mod.")
	var mod_sprites: Dictionary
	for key in mod_config.get_section_keys(UPPER_BODY_WEARABLE.find_key(upper_body_wearable)):
		var vals: Array = mod_config.get_value(UPPER_BODY_WEARABLE.find_key(upper_body_wearable), key, [])
		if vals == []: Utils.show_error_screen("Unable to load selected mod.")
		
		var sp = load_sprite(vals.pop_back())
		sp.name = key
		sp.centered = false
		mod_sprites[key] = sp
		var p_sp = base_sprites.get(vals.pop_back())
		sp.hframes = p_sp.hframes
		sp.vframes = p_sp.vframes
		sp.frame = p_sp.frame
		p_sp.frame_changed.connect(func(): sp.frame = p_sp.frame)
		p_sp.add_child(sp)
	# Till above loading sprites(Texture) for selected upper body wearable 
#	match upper_body_wearable:
#		UPPER_BODY_WEARABLE.IS_BRA:
#			if not base_sprites.has("Base_Breast"):
#				Utils.show_error_screen("Unable to load selected mod.")
#			for n in mod_sprites:
#				var sp: Sprite2D = mod_sprites.get(n)
#				var p_sp = base_sprites.get("Base_Breast")
#				sp.hframes = p_sp.hframes
#				sp.vframes = p_sp.vframes
#				sp.frame = p_sp.frame
#				p_sp.frame_changed.connect(func(): sp.frame = p_sp.frame)
#				p_sp.add_child(sp)
#		UPPER_BODY_WEARABLE.IS_SHORT_SLEEVE_SHIRT:
#			if not (base_sprites.has("Base_Breast")):
#				Utils.show_error_screen("Unable to load selected mod.")
#			print_debug(mod_sprites) # Thinking to update config file to have base parent name and sprite as value.

func update_lower_body_wearable():
	print_debug("upper body signal connected")
	for parent_name in ["Base_Butt"]:
		if base_sprites.has(parent_name):
			var child_node = base_sprites[parent_name].get_children()
			for cn in child_node: cn.queue_free()
	print_debug(LOWER_BODY_WEARABLE.find_key(lower_body_wearable))
	print_debug(mod_config.get_sections().has(LOWER_BODY_WEARABLE.find_key(lower_body_wearable)))
	# Till above all the childs are removed from base sprites
	if not LOWER_BODY_WEARABLE.find_key(lower_body_wearable) in mod_config.get_sections():
		Utils.show_error_screen("Unable to load selected mod.")
	var mod_sprites: Dictionary
	for key in mod_config.get_section_keys(LOWER_BODY_WEARABLE.find_key(lower_body_wearable)):
		var vals: Array = mod_config.get_value(LOWER_BODY_WEARABLE.find_key(lower_body_wearable), key, [])
		if vals == []: Utils.show_error_screen("Unable to load selected mod.")
		
		var sp = load_sprite(vals.pop_back())
		sp.name = key
		sp.centered = false
		mod_sprites[key] = sp
		var p_sp = base_sprites.get(vals.pop_back())
		sp.hframes = p_sp.hframes
		sp.vframes = p_sp.vframes
		sp.frame = p_sp.frame
		p_sp.frame_changed.connect(func(): sp.frame = p_sp.frame)
		p_sp.add_child(sp)

func update_mod_view():
	if base_sprites.has("Base_Breast"):
		for child in base_sprites["Base_Breast"].get_children():
			match child.name:
				"B_Bra":
					child.z_index = 0 if view == VIEW.BACK else 0
				"Base_Breast", "ShortSleeveShirt":
					child.z_index = 1 if view == VIEW.BACK else 0
	if base_sprites.has("Base_Butt"):
		for child in base_sprites["Base_Butt"].get_children():
			child.z_index = 0 if view == VIEW.BACK else 1
			print_debug(child.name, child.z_index)
	

