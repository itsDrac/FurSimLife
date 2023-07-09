extends CharacterSprite
class_name CharacterMod

# will have to call this from Tags script on which part would be loaded.(Not everything have to be loaded)


var mod_sprites: Dictionary
var mod_sections: Array
var mod_config: ConfigFile
var mod_folder_name: StringName # first set the value for the selected mod


func _init():
	super()

	view_changed.connect(change_mod_view)
	pregnancy_changed.connect(toggle_visible_of_wearable)
	upper_body_wearable.item_added.connect(func():
		var added = UPPER_BODY_WEARABLE.find_key(upper_body_wearable.last_added)
		add_wearable_mod(added)
		)
	lower_body_wearable.item_added.connect(func():
		var added = LOWER_BODY_WEARABLE.find_key(lower_body_wearable.last_added)
		add_wearable_mod(added)
		)
	piercing.item_added.connect(func():
		var added = PIERCING.find_key(piercing.last_added)
		add_wearable_mod(added)
		)
	accessories.item_added.connect(func():
		var added = ACCESSORIES.find_key(accessories.last_added)
		add_wearable_mod(added)
		)
	makeup.item_added.connect(func():
		var added = MAKEUP.find_key(makeup.last_added)
		add_wearable_mod(added)
		)
	upper_body_wearable.item_removed.connect(func():
		var removed = UPPER_BODY_WEARABLE.find_key(upper_body_wearable.last_removed)
		remove_wearable_mod(removed)
		)
	lower_body_wearable.item_removed.connect(func():
		var removed = LOWER_BODY_WEARABLE.find_key(lower_body_wearable.last_removed)
		remove_wearable_mod(removed) 
		)
	piercing.item_removed.connect(func():
		var removed = PIERCING.find_key(piercing.last_removed)
		remove_wearable_mod(removed)
		)
	accessories.item_removed.connect(func():
		var removed = ACCESSORIES.find_key(accessories.last_removed)
		remove_wearable_mod(removed)
		)
	makeup.item_removed.connect(func():
		var removed = MAKEUP.find_key(makeup.last_removed)
		remove_wearable_mod(removed)
		)

## Returns all the available Mods.
static func get_mod_list():
	var mods: Dictionary
	var config = ConfigFile.new()
	config.load("res://mods/config.cfg")
	if config.has_section("Mods"):
		for key in config.get_section_keys("Mods"):
			var value = config.get_value("Mods", key)
			mods[key] = value
	return mods


## Loads the selected Mod
func load_config(folder_name):
	mod_folder_name = folder_name
	mod_config = ConfigFile.new()
	mod_config.load("res://mods/%s/%s/%s/config.cfg"\
	%[mod_folder_name, RACE.find_key(race), GENDER.find_key(gender)])
	mod_sections = mod_config.get_sections()
	

func load_sprite(file_name) -> Sprite2D:
	if file_name == "":
		Utils.show_error_screen("Unable to load selected mod.")
	var s = Sprite2D.new()
	var path = "res://mods/%s/%s/%s/%s"\
	%[mod_folder_name, RACE.find_key(race), GENDER.find_key(gender), file_name]
	s.texture = load(path)
	return s


func add_wearable_mod(added):
	
	if not mod_config.get_sections().has(added):
		Utils.show_error_screen("Unable to load selected mod.")
	
	for key in mod_config.get_section_keys(added):
		var vals: Array = mod_config.get_value(added, key, [])
		if vals == []: Utils.show_error_screen("Unable to load selected mod.")
		
		var p_sp = base_sprites.get(vals[0])
		if not p_sp: Utils.show_error_screen("Couldn't load parent mod for %s"%key)
		var sp = load_sprite(vals[1])
		mod_sprites[key] = sp
		sp.name = key
		sp.centered = false
		sp.hframes = 5 if sp.name == "Base_Penis" else p_sp.hframes
		sp.vframes = p_sp.vframes
		sp.frame = p_sp.frame
		p_sp.frame_changed.connect(func():
			if is_instance_valid(sp):
				sp.frame = p_sp.frame
		)
		p_sp.add_child(sp)

func remove_wearable_mod(removed):
	if not mod_config.get_sections().has(removed):
		Utils.show_error_screen("Unable to load selected mod.")
	
	for key in mod_config.get_section_keys(removed):
		
		var sp = mod_sprites.get(key)
		if sp:
			sp.queue_free()
			mod_sprites.erase(key)


## Addes only base Sprite2D node to there parent with loaded mod as texture.
func add_base_mod():
	var section = "Base_Mod"
	if not mod_config.get_sections().has(section):
		Utils.show_error_screen("Unable to load selected mod.")
	
	for key in mod_config.get_section_keys(section):
		var vals: Array = mod_config.get_value(section, key, [])
		if vals == []: Utils.show_error_screen("Unable to load selected mod.")
		
		var p_sp = base_sprites.get(vals[0])
		var sp = load_sprite(vals[1])
		sp.name = key
		sp.centered = false
		sp.vframes = p_sp.vframes
		p_sp.frame_changed.connect(func(): sp.frame_coords.y = p_sp.frame_coords.y)
		match key:
			"FrontHair":
				sp.hframes = 4
				front_hair_changed.connect(func(): sp.frame_coords.x = front_hair)
				sp.z_index = 1
			"BackHair":
				sp.hframes = 6
				back_hair_changed.connect(func(): sp.frame_coords.x = back_hair)
				sp.z_index = -4
			"Iris","EyeBrowLashes":
				sp.hframes = 1
			"Pregbelly":
				sp.hframes = 6
				sp.z_index = 1
				pregbelly_changed.connect(func(): sp.frame_coords.x = pregbelly)
			"Mothkin_Arm":
				sp.hframes = 1
				sp.z_index = 3
			"Mothkin_Leg":
				sp.hframes = 1
				sp.z_index = 1
		p_sp.add_child(sp)
		mod_sprites[key] = sp


## This function is called everytime view is changed.
func change_mod_view():
	for key in mod_sprites:
		var sp = mod_sprites.get(key)
		match key:
			"FrontHair":
				sp.z_index = -3 if view == VIEW.BACK else 1
			"BackHair":
				if view == VIEW.FRONT: sp.z_index = -4
				if view == VIEW.BACK: sp.z_index = 8
				if view == VIEW.SIDE: sp.z_index = 4
			"Pregbelly":
				sp.z_index = 1 if view == VIEW.BACK else 1
			"Mothkin_Arm", "BRACELET1":
				sp.z_index = 9 if view == VIEW.SIDE else 3
			"Underwear", "NIPPLE_PIERCED":
				sp.z_index = 0
			"SkirtsButt", "ANKLEBRACELET":
				sp.z_index = 1 #if view == VIEW.FRONT else 0
			"NECKLACE":
				sp.z_index = 5
			"NECKLACEJEWEL1", "NECKLACEJEWEL2":
				sp.z_index = 4
			"PAINTEDNAILSRED":
				if view == VIEW.FRONT: sp.z_index = -1
				if view == VIEW.BACK: sp.z_index = 0
				if view == VIEW.SIDE: sp.z_index = 6
			"PantsDesign", "ShortsDesign":
				if view == VIEW.FRONT: sp.z_index = 2
				if view == VIEW.BACK: sp.z_index = 0
				if view == VIEW.SIDE: sp.z_index = 1
			"ShortSleeveShirt", "LongSleeveShirt", "ShortShirt":
				sp.z_index = 3 if view == VIEW.BACK else 2
			"Bra":
				sp.z_index = 2 if view == VIEW.BACK else 1
			"VAGINAL_PIERCED", "ANAL_PIERCED":
				sp.z_index = 2 if view == VIEW.BACK else 0
			"RINGTHUMBS", "RINGINDEX", "RINGMIDDLE", "RINGRING", "RINGPINKY":
				sp.z_index = 4 if view == VIEW.SIDE else 0

func toggle_visible_of_wearable():
	var lower_item = lower_body_wearable.qarray.map(func(x): return LOWER_BODY_WEARABLE.find_key(x))
	var upper_item = upper_body_wearable.qarray.map(func(x): return UPPER_BODY_WEARABLE.find_key(x))
	var toggle_item = func(item):
		for key in mod_config.get_section_keys(item):
			var vals: Array = mod_config.get_value(item, key, [])
			if vals == []: Utils.show_error_screen("Unable to load selected mod.")
			
			var sp = mod_sprites.get(key)
			sp.visible = not pregnancy
	for item in lower_item:
		toggle_item.call(item)
	for item in upper_item:
		toggle_item.call(item)

func change_zindex(name, zindex):
	if mod_sprites.has(name):
		var sp = mod_sprites.get(name)
		sp.z_index = zindex
