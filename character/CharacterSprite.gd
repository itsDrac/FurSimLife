extends CharacterTag
class_name CharacterSprite

var race_config
var base_sprites: Dictionary
var sprites: Dictionary
var mod: CharacterMod


func _init():
	super()
	race_config = ConfigFile.new()
	var err = race_config.load("res://character/sprites/config.cfg")
	if err != OK:
		Utils.show_error_screen("Could not load base sprite")
	# Connecting Signals:
	view_changed.connect(update_view)
	
#	breast_size_changed.connect(change_breast)
##	butt_size_changed.connect(change_butt_size)
#	base_breast_view_changed.connect(change_z_index)
#
#	if race_config.has_section("Race"):
#		print_debug(race_config.get_value("Race", "IS_HUMAN"))
	

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

func setup():
	_load_sprite()
	for texture in sprites:
		var sp = Sprite2D.new()
		sp.centered = false
		sp.texture = sprites[texture]
		sp.name = texture
		match texture:
			"Base_Torso", "Base_Nose":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				base_sprites[texture] = sp
			"Base_Hair":
				sp.hframes = 1
				sp.vframes = 9
#				sp.z_index = 1
				sp.frame_coords.y = gender+view
				base_sprites[texture] = sp
			"Face_EyeBall":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				base_sprites[texture] = sp
			"Base_Butt":
				sp.hframes = 3
				sp.vframes = 9
				base_sprites[texture] = sp
				butt_size_changed.connect(func(): _set_frame(sp, butt_size))
				butt_size_changed.emit()
			"Base_Breast":
				sp.hframes = 6
				sp.vframes = 9
				base_sprites[texture] = sp
				breast_size_changed.connect(func(): _set_frame(sp, breast_size))
				breast_size_changed.emit()
			"Base_Antenna":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				base_sprites[texture] = sp
			"Base_ArmBackSide", "Base_ArmLowerSide", "Base_ArmUpperSide":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				base_sprites[texture] = sp
			"Base_Wing":
				sp.hframes = 1
				sp.vframes = 9
				sp.z_index = -1
				sp.frame_coords.y = gender+view
				base_sprites[texture] = sp
			"Base_Ovipositor":
				sp.hframes = 6
				sp.vframes = 9
				base_sprites[texture] = sp
				ovipositor_changed.connect(func(): _set_frame(sp, anus_orifices))
				ovipositor_changed.emit()
			"Base_Anus":
				sp.hframes = 6
				sp.vframes = 9
				base_sprites[texture] = sp
				anus_orifices_size_change.connect(func(): _set_frame(sp, anus_orifices))
				anus_orifices_size_change.emit()
			"Base_Vagina":
				sp.hframes = 6
				sp.vframes = 9
				base_sprites[texture] = sp
				vagina_size_change.connect(func(): _set_frame(sp, vagina))
				vagina_size_change.emit()
			"Base_Tail":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				sp.z_index = -1
				base_sprites[texture] = sp
			"Base_Ear":
				sp.hframes = 1
				sp.vframes = 9
				sp.frame_coords.y = gender+view
				base_sprites[texture] = sp
			_:
				print_debug(texture)

func update_view():
	for s in base_sprites:
		var sp = base_sprites[s]
		sp.frame_coords.y = gender+view
		match s:
			"Base_Breast":
				sp.z_index = -1 if view == VIEW.BACK else 0
			"Base_Wing":
				sp.z_index = 0 if view == VIEW.BACK else -1
			"Base_Ovipositor":
				sp.z_index = 1 if view == VIEW.BACK else -1
			"Base_Antenna":
				sp.z_index = -1 if view == VIEW.BACK else 0
			"Base_Tail":
				sp.z_index = 0 if view == VIEW.BACK else -1

#func _set_bbutt_frame():
#	if not base_sprites.has("Base_Butt"):
#		return
#	var sp = base_sprites["Base_Butt"]
#	sp.frame_coords.x = butt_size
#	sp.frame_coords.y = gender+view
#
#func _set_bbreast_frame():
#	if not base_sprites.has("Base_Breast"):
#		return
#	var sp = base_sprites["Base_Breast"]
#	sp.frame_coords.x = breast_size
#	sp.frame_coords.y = gender+view
#
#func _set_ovipositor_frame():
#	if not base_sprites.has("Base_Ovipositor"):
#		return
#	var sp = base_sprites["Base_Ovipositor"]
#	sp.frame_coords.x = ovipositor
#	sp.frame_coords.y = gender+view
#
#func _set_anus_frame():
#	if not base_sprites.has("Base_Anus"):
#		return
#	var sp = base_sprites["Base_Anus"]
#	sp.frame_coords.x = anus_orifices
#	sp.frame_coords.y = gender+view

func _set_frame(sp, x):
	sp.frame_coords.x = x
	sp.frame_coords.y = gender+view
