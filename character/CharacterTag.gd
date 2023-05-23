extends CharacterStats
class_name CharacterTag

enum BUTT_SIZE {
	IS_BUTT_SIZE1,
	IS_BUTT_SIZE2,
	IS_BUTT_SIZE3,
}

enum BREAST_SIZE {
	IS_BREAST_SIZE0,
	IS_BREAST_SIZE1,
	IS_BREAST_SIZE2,
	IS_BREAST_SIZE3,
	IS_BREAST_SIZE4,
	IS_BREAST_SIZE5,
}

enum PENIS {
	HAS_HUMAN_PENIS,
	HAS_CANINE_PENIS, 
}

enum PENIS_SIZE {
	HAS_PENIS_SIZE0,

	HAS_SOFT_PENIS_SIZE1,
	HAS_SOFT_PENIS_SIZE2,
	HAS_SOFT_PENIS_SIZE3,
	HAS_SOFT_PENIS_SIZE4,
	HAS_HARD_PENIS_SIZE1,
	HAS_HARD_PENIS_SIZE2,
	HAS_HARD_PENIS_SIZE3,
	HAS_HARD_PENIS_SIZE4,

}

enum VAGINA {
	HAS_VAGINAL_ORIFICE_SIZE0,
	HAS_VAGINAL_ORIFICE_SIZE1,
	HAS_VAGINAL_ORIFICE_SIZE2,
	HAS_VAGINAL_ORIFICE_SIZE3,
	HAS_VAGINAL_ORIFICE_SIZE4,
}

enum OVIPOSITOR {
	HAS_OVIPOSITOR_SIZE0,
	HAS_OVIPOSITOR_SIZE1,
	HAS_OVIPOSITOR_SIZE2,
	HAS_OVIPOSITOR_SIZE3,
	HAS_OVIPOSITOR_SIZE4,
}

enum TESTICLE_SIZE {
	HAS_TESTICLE_SIZE0,
	HAS_TESTICLE_SIZE1,
	HAS_TESTICLE_SIZE2,
	HAS_TESTICLE_SIZE3,
	HAS_TESTICLE_SIZE4,
}

enum ANUS_ORIFICES {
	HAS_ANUS_ORIFICES_SIZE1,
	HAS_ANUS_ORIFICES_SIZE2,
	HAS_ANUS_ORIFICES_SIZE3,
	HAS_ANUS_ORIFICES_SIZE4,
}

enum PREGBELLY {
	HAS_PREGBELLY_SIZE0,
	HAS_PREGBELLY_SIZE1,
	HAS_PREGBELLY_SIZE2,
	HAS_PREGBELLY_SIZE3,
	HAS_PREGBELLY_SIZE4,
	HAS_PREGBELLY_SIZE5,
}

enum EGGPREGBELLY {
	HAS_EGGPREGBELLY_SIZE0,
	HAS_EGGPREGBELLY_SIZE1,
	HAS_EGGPREGBELLY_SIZE2,
	HAS_EGGPREGBELLY_SIZE3,
	HAS_EGGPREGBELLY_SIZE4,
	HAS_EGGPREGBELLY_SIZE5,
}

enum EGGPREGBELLY_ANAL {
	HAS_AEGGPREGBELLY_SIZE0,
	HAS_AEGGPREGBELLY_SIZE1,
	HAS_AEGGPREGBELLY_SIZE2,
	HAS_AEGGPREGBELLY_SIZE3,
	HAS_AEGGPREGBELLY_SIZE4,
	HAS_AEGGPREGBELLY_SIZE5,
}

enum AGE {
	IS_YOUNGADULT,
	IS_ADULT,
	IS_OLDADULT,
}

enum PIERCING {
	IS_NIPPLE_PIERCED, # This is dependedent on BREAST_SIZE the frame for this is equal as breat frame
	IS_VAGINAL_PIERCED,
	IS_ANAL_PIERCED,
	IS_PENIS_PIERCED, # This is dependednt on PENIS the frame for this is equal as penis frame
	IS_OVIPOSITOR_PIERCED, # This is dependednt on OVIPOSITOR the frame for this is equal as penis frame
	IS_EYEBROW_PIERCED,
	IS_LIP_PIERCED,
	IS_NOSE_PIERCED,
	IS_HUMANEARSPIERCEDCOLORRED,
	IS_HALFFOXKINEARSPIERCED1,
	IS_HALFFOXKINEARSPIERCED2,
	IS_FOXKINEARSPIERCED1,
	IS_FOXKINEARSPIERCED2,
	IS_MOTHKINANTENNARINGS,
}

enum SKIN_COLOR {
	HAS_PALESKIN
}

enum HAIR {
	HAS_PONYTAIL1,
	HAS_PONYTAIL2,
	HAS_PONYTAIL3,
	HAS_STRAIGHTH1,
	HAS_STRAIGHTH2,
	HAS_STRAIGHTH3,
}

enum UPPER_BODY_WEARABLE {
	IS_BRA,
	IS_SHORT_SLEEVE_SHIRT,
	IS_LONG_SLEEVE_SHIRT,
	IS_SHORT_SHIRT
}

enum LOWER_BODY_WEARABLE {
	IS_UNDERWEAR,
	IS_PANT,
	IS_SHORT,
	IS_SKIRT
}

enum FRONT_HAIR {
	HAS_FRONTHAIR1,
	HAS_FRONTHAIR2,
	HAS_FRONTHAIR3,
	HAS_FRONTHAIR4,
}

enum ACCESSORIES {
	HAS_BRACELET1,
	HAS_ANKLEBRACELET,
	HAS_COLLAR1,
	HAS_COLLAR2,
	HAS_COLLAR3,
	HAS_COLLARTAG1,
	HAS_COLLARTAG2,
	HAS_RINGTHUMBS,
	HAS_RINGINDEX,
	HAS_RINGMIDDLE,
	HAS_RINGRING,
	HAS_RINGPINKY,
	HAS_NECKLACE,
	HAS_NECKLACEJEWEL1,
	HAS_NECKLACEJEWEL2,
}

enum MAKEUP {
	HAS_PAINTEDNAILSRED,
	HAS_EYEMAKEUP,
	HAS_LIPSTICK,
	HAS_BLUSH,
}

signal butt_size_changed
signal breast_size_changed
signal ovipositor_changed
signal anus_orifices_size_change
signal vagina_size_change

@export_category("Character Tag")
@export var butt_size: BUTT_SIZE :
	get: return butt_size
	set(val): 
		butt_size = BUTT_SIZE.IS_BUTT_SIZE1 if gender == CharacterStats.GENDER.MALE else val
		butt_size_changed.emit()
@export var breast_size: BREAST_SIZE :
	get: return breast_size
	set(val): 
		breast_size = BREAST_SIZE.IS_BREAST_SIZE0 if gender == CharacterStats.GENDER.MALE else val
		breast_size_changed.emit()
@export var penis: PENIS :
	get: return penis
	set(val): penis = set_penis(val)
@export var penis_size: PENIS_SIZE :
	get: return penis_size
	set(val): penis_size = set_penis_size(val)
@export var vagina: VAGINA :
	get: return vagina
	set(val): 
		vagina = VAGINA.HAS_VAGINAL_ORIFICE_SIZE0 if self.gender == CharacterStats.GENDER.MALE else int(val == VAGINA.HAS_VAGINAL_ORIFICE_SIZE0) + val
		vagina_size_change.emit()
@export var ovipositor: OVIPOSITOR :
	get: return ovipositor
	set(val):
		ovipositor = set_ovipositor(val)
		ovipositor_changed.emit()
@export var testicle_size: TESTICLE_SIZE :
	get: return testicle_size
	set(val): testicle_size = set_testicle_size(val)
@export var anus_orifices: ANUS_ORIFICES :
	get: return anus_orifices
	set(val):
		anus_orifices = val
		anus_orifices_size_change.emit()
@export var pregbelly: PREGBELLY:
	get: return pregbelly
	set(val): pregbelly = set_pregbelly(val)
@export var eggpregbelly: EGGPREGBELLY:
	get: return eggpregbelly
	set(val): pregbelly = set_pregbelly(val)
@export var eggpregbelly_anal: EGGPREGBELLY_ANAL:
	get: return eggpregbelly_anal
	set(val): eggpregbelly_anal = val if eggs_in_ass else EGGPREGBELLY_ANAL.HAS_AEGGPREGBELLY_SIZE0
@export var age: AGE
@export var skin_color: SKIN_COLOR
@export var hair: HAIR
@export var front_hair: FRONT_HAIR
@export var piercing: Array[PIERCING] = []
@export var upper_body_wearable: UPPER_BODY_WEARABLE
@export var lower_body_wearable: LOWER_BODY_WEARABLE
@export var accessories: Array[ACCESSORIES] = []
@export var makeup: Array[MAKEUP] = []
@export var has_bulge: bool = false if gender == GENDER.FEMALE else true # dependent on Penis size

func _init():
	super()
	pregnancy_changed.connect(func (): pregbelly=pregbelly)

func _to_string():
	print(super())
	return "\nCharacterTag {
	Butt size: {butt_size}
	Breast size: {breast_size}
	Penis: {penis}
	Penis_size: {penis_size}
	Vagina: {vagina}
	Ovipositor: {ovipositor}
	Testicle size: {testicle_size}
	Anus orifices: {anus_orifices}
	Pregbelly: {pregbelly}
	Eggpregbelly: {eggpregbelly}
	Eggpregbelly anal: {eggpregbelly_anal}
	Age: {age}
	Skin color: {skin_color}
	Hair: {hair}
	Front hair: {front_hair}
	Piercing: {piercing}
	Upper Body Wearable: {upper_body_wearable}
	Lower Body Wearable: lower_body_wearable
	Accessories: {accessories}
	Makeup: {makeup}
	Bulge: {has_bulge}
}".format({
	"butt_size": BUTT_SIZE.find_key(self.butt_size),
	"breast_size": BREAST_SIZE.find_key(self.breast_size),
	"penis": PENIS.find_key(self.penis),
	"penis_size": PENIS_SIZE.find_key(self.penis_size),
	"vagina": VAGINA.find_key(self.vagina),
	"ovipositor": OVIPOSITOR.find_key(self.ovipositor),
	"testicle_size": TESTICLE_SIZE.find_key(self.testicle_size),
	"anus_orifices": ANUS_ORIFICES.find_key(self.anus_orifices),
	"pregbelly": PREGBELLY.find_key(self.pregbelly),
	"eggpregbelly": EGGPREGBELLY.find_key(self.eggpregbelly),
	"eggpregbelly_anal": EGGPREGBELLY_ANAL.find_key(self.eggpregbelly_anal),
	"age": AGE.find_key(self.age),
	"piercing": self.piercing.map(func(n): return PIERCING.find_key(n)),
	"skin_color": SKIN_COLOR.find_key(self.skin_color),
	"hair": HAIR.find_key(self.hair),
	"front_hair": FRONT_HAIR.find_key(self.front_hair),
	"upper_body_wearable": UPPER_BODY_WEARABLE.find_key(self.upper_body_wearable),
	"lower_body_wearable": LOWER_BODY_WEARABLE.find_key(self.lower_body_wearable),
	"accessories":  self.accessories.map(func(n): return ACCESSORIES.find_key(n)),
	"makeup": self.makeup.map(func(n): return MAKEUP.find_key(n)),
	"has_bulge": self.has_bulge,
})

func add_tags():
	self.butt_size = BUTT_SIZE.IS_BUTT_SIZE2#randi_range(BUTT_SIZE.IS_BUTT_SIZE1, BUTT_SIZE.IS_BUTT_SIZE3)
	self.breast_size = randi_range(BREAST_SIZE.IS_BREAST_SIZE0, BREAST_SIZE.IS_BREAST_SIZE5)
	self.penis = PENIS.HAS_CANINE_PENIS
	self.penis_size = randi_range(PENIS_SIZE.HAS_SOFT_PENIS_SIZE1, PENIS_SIZE.HAS_SOFT_PENIS_SIZE4)
	self.vagina = VAGINA.HAS_VAGINAL_ORIFICE_SIZE0
	self.ovipositor = OVIPOSITOR.HAS_OVIPOSITOR_SIZE0
	self.testicle_size = randi_range(TESTICLE_SIZE.HAS_TESTICLE_SIZE0,TESTICLE_SIZE.HAS_TESTICLE_SIZE4)
	self.anus_orifices = ANUS_ORIFICES.HAS_ANUS_ORIFICES_SIZE1
	self.pregbelly = randi_range(PREGBELLY.HAS_PREGBELLY_SIZE1, PREGBELLY.HAS_PREGBELLY_SIZE5) if pregnancy else PREGBELLY.HAS_PREGBELLY_SIZE0
	self.eggpregbelly = randi_range(EGGPREGBELLY.HAS_EGGPREGBELLY_SIZE1, EGGPREGBELLY.HAS_EGGPREGBELLY_SIZE5) if eggs else EGGPREGBELLY.HAS_EGGPREGBELLY_SIZE0
	self.eggpregbelly_anal = EGGPREGBELLY_ANAL.HAS_AEGGPREGBELLY_SIZE0
	self.age = randi_range(AGE.IS_YOUNGADULT, AGE.IS_OLDADULT)
	self.skin_color = randi_range(SKIN_COLOR.HAS_PALESKIN, SKIN_COLOR.HAS_PALESKIN)
	self.hair = randi_range(HAIR.HAS_PONYTAIL1, HAIR.HAS_STRAIGHTH3)
	self.front_hair = randi_range(FRONT_HAIR.HAS_FRONTHAIR1, FRONT_HAIR.HAS_FRONTHAIR4)
	self.upper_body_wearable = UPPER_BODY_WEARABLE.values().pick_random()
	self.lower_body_wearable = LOWER_BODY_WEARABLE.values().pick_random()
	self.has_bulge = false

# Set Tags functions
func append_piercing(pie: PIERCING):
	if pie in self.piercing:
		return
	match pie:
		PIERCING.IS_VAGINAL_PIERCED:
			if not gender == GENDER.MALE:
				self.piercing.append(pie)
		PIERCING.IS_PENIS_PIERCED:
			if not gender == GENDER.FEMALE:
				self.piercing.append(pie)
		PIERCING.IS_OVIPOSITOR_PIERCED:
			if race == RACE.MOTHKIN and gender == GENDER.FEMALE:
				self.piercing.append(pie)
		PIERCING.IS_HUMANEARSPIERCEDCOLORRED:
			if not race == RACE.FOXKIN:
				self.piercing.append(pie)
		PIERCING.IS_HALFFOXKINEARSPIERCED1, PIERCING.IS_HALFFOXKINEARSPIERCED2:
			if race == RACE.HALFFOXKIN:
				self.piercing.append(pie)
		PIERCING.IS_FOXKINEARSPIERCED1, PIERCING.IS_FOXKINEARSPIERCED2:
			if race == RACE.FOXKIN:
				self.piercing.append(pie)
		PIERCING.IS_MOTHKINANTENNARINGS:
			if race == RACE.MOTHKIN:
				self.piercing.append(pie)
		_:
			self.piercing.append(pie)

func append_accessories(acc):
	if not acc in accessories:
		accessories.append(acc)

func append_makup(mkp):
	if not mkp in makeup:
		makeup.append(mkp)

func set_penis(val):
	if race == RACE.HUMAN:
		return PENIS.HAS_HUMAN_PENIS
	if race == RACE.FOXKIN:
		return PENIS.HAS_CANINE_PENIS
	return val

func set_penis_size(val):
	if self.gender == CharacterStats.GENDER.FEMALE:
		return PENIS_SIZE.HAS_PENIS_SIZE0
	return int(val == PENIS_SIZE.HAS_PENIS_SIZE0) + val

func set_ovipositor(val):
	if self.race == CharacterStats.RACE.MOTHKIN and self.gender == CharacterStats.GENDER.FEMALE:
		return int(val == OVIPOSITOR.HAS_OVIPOSITOR_SIZE0) + val
	return OVIPOSITOR.HAS_OVIPOSITOR_SIZE0

func set_testicle_size(val):
	if self.gender == CharacterStats.GENDER.FEMALE:
		return TESTICLE_SIZE.HAS_TESTICLE_SIZE0
	if self.gender == CharacterStats.GENDER.MALE:
		return int(val == TESTICLE_SIZE.HAS_TESTICLE_SIZE0)+val
	
	return val

func set_pregbelly(val):
	if gender == CharacterStats.GENDER.MALE or not pregnancy:
		return PREGBELLY.HAS_PREGBELLY_SIZE0
	return int(val == PREGBELLY.HAS_PREGBELLY_SIZE0) + val

func set_eggpregbelly_anal(val):
	return val if eggs_in_ass else EGGPREGBELLY_ANAL.HAS_AEGGPREGBELLY_SIZE0

# Signals functions.

