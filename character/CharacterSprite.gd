extends CharacterTag
class_name CharacterSprite

var race_config
var base_sprites: Dictionary
var sprites: Dictionary

signal base_sprites_added

func _init():
	super()
	stats_genrated.connect(setup_sprite)
	race_config = ConfigFile.new()
	var err = race_config.load("res://character/sprites/config.cfg")
	if err != OK:
		Utils.show_error_screen("Could not load base sprite")
	# Connecting Signals:
	view_changed.connect(update_view)
	lower_body_wearable.item_added.connect(toggle_visible_of_lower_genitals)
	lower_body_wearable.item_removed.connect(toggle_visible_of_lower_genitals)

func _load_sprite():
	var folder_name: StringName
	if not race_config.has_section("RACE"):
		Utils.show_error_screen("Could not find RACE section in base sprites")
#	match race:
#		CharacterStats.RACE.HUMAN:
	folder_name = race_config.get_value("RACE", RACE.find_key(race), "")
	if folder_name == "":
		Utils.show_error_screen("Could not find selected race in base sprites")
	_load_base_sprites(folder_name)

func _load_base_sprites(folder_name: StringName):
	var config_file = ConfigFile.new()
	config_file.load("res://character/sprites/"+folder_name+"/config.cfg")
	if config_file.has_section("Base_Sprites"):
		for key in config_file.get_section_keys("Base_Sprites"):
			var sprite_name = config_file.get_value("Base_Sprites",key)
			var texture_path = "res://character/sprites/"+folder_name+"/"+sprite_name
			var base_texture = load(texture_path)
			sprites[key] = base_texture

func setup_sprite():
	_load_sprite()
	for texture in sprites:
		var sp = Sprite2D.new()
		sp.centered = false
		sp.texture = sprites[texture]
		sp.name = texture
		match texture:
			"Base_Torso", "Face_EyeBall":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				base_sprites[texture] = sp
			"Base_ArmBackSide", "Base_ArmUpperSide":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				sp.z_index = 3
				base_sprites[texture] = sp
			"Base_ArmLowerSide":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				sp.z_index = 2
				base_sprites[texture] = sp
			"Base_Hair","Face_EyeBall", "Base_Nose":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				sp.z_index = 1
				base_sprites[texture] = sp
			"Base_Antenna":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				sp.z_index = 2
				base_sprites[texture] = sp
			"Base_Tail", "Base_Ear":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				sp.z_index = -1
				base_sprites[texture] = sp
			"Base_Butt":
				sp.hframes = 3
				sp.vframes = 9
				base_sprites[texture] = sp
				butt_size_changed.connect(func(): _set_frame(sp, butt_size))
#				butt_size_changed.emit()
			"Base_Breast":
				sp.hframes = 6
				sp.vframes = 9
				sp.z_index = 1
				base_sprites[texture] = sp
				breast_size_changed.connect(func(): _set_frame(sp, breast_size))
#				breast_size_changed.emit()
			"Base_Wing":
				sp.hframes = 1
				sp.vframes = 9
				sp.z_index = -2
				sp.frame_coords.y = gender+view
				base_sprites[texture] = sp
			"Base_Ovipositor":
				sp.hframes = 5
				sp.vframes = 9
				sp.z_index = -1
				base_sprites[texture] = sp
				ovipositor_changed.connect(func(): _set_frame(sp, ovipositor))
#				ovipositor_changed.emit()
			"Base_Anus":
				sp.hframes = 6
				sp.vframes = 9
				sp.z_index = -2
				base_sprites[texture] = sp
				anus_orifices_size_change.connect(func(): _set_frame(sp, anus_orifices))
#				anus_orifices_size_change.emit()
			"Base_Vagina":
				sp.hframes = 5
				sp.vframes = 9
#				sp.z_index = -1
				base_sprites[texture] = sp
				vagina_size_change.connect(func(): _set_frame(sp, vagina))
#				vagina_size_change.emit()
			"Base_Testicles":
				sp.hframes = 5
				sp.vframes = 9
				sp.z_index = 2
				base_sprites[texture] = sp
				testicle_size_changed.connect(func(): _set_frame(sp, testicle_size))
#				testicle_size_changed.emit()
			"Base_Penis":
				sp.hframes = 17
				sp.vframes = 9
				sp.z_index = 1
				base_sprites[texture] = sp
				penis_size_changed.connect(func(): _set_frame(sp, penis_size+penis))
				penis_changed.connect(func(): _set_frame(sp, penis_size+penis))
			_:
				print_debug(texture)
	base_sprites_added.emit()

func update_view():
	for s in base_sprites:
		var sp: Sprite2D = base_sprites[s]
		sp.frame_coords.y = gender+view
		match s:
			"Base_Breast":
				sp.z_index = 0 if view == VIEW.BACK else 1
			"Base_Wing":
				if view == VIEW.FRONT: sp.z_index = -2
				elif view == VIEW.BACK: sp.z_index = 4
				elif view == VIEW.SIDE: sp.z_index = -1
			"Base_Ovipositor", "Base_Tail":
				if view == VIEW.FRONT: sp.z_index = -1
				elif view == VIEW.BACK: sp.z_index = 3
				elif view == VIEW.SIDE: sp.z_index = -2
			"Base_Antenna":
				sp.z_index = -1 if view == VIEW.BACK else 2
			"Base_Tail":
				sp.z_index = 0 if view == VIEW.BACK else -1
			"Base_Vagina":
				sp.z_index = -1 if view == VIEW.BACK else 0
			"Base_Ovipositor":
				sp.z_index = -1 if view == VIEW.BACK else 0
			"Base_Ear":
				sp.z_index = 2 if view == VIEW.SIDE else -1
			"Base_Penis":
				sp.z_index = 2 if view == VIEW.FRONT else -2
			"Base_Testicles":
				sp.z_index = 2 if view == VIEW.FRONT else -1
		

func _set_frame(sp: Sprite2D, x):
	sp.frame_coords.x = x
	sp.frame_coords.y = gender+view

func toggle_visible_of_lower_genitals():
	var p_sp = [base_sprites.get("Base_Vagina"),base_sprites.get("Base_Testicles"), base_sprites.get("Base_Penis")]
	for sp in p_sp:
		if not sp == null:
			sp.visible = not bool(lower_body_wearable.qarray.size())
