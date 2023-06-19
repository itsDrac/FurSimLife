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
	HAS_CANINE_PENIS = 0, 
	HAS_HUMAN_PENIS = 8,
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

enum AGE {
	IS_YOUNGADULT,
	IS_ADULT,
	IS_OLDADULT,
}

enum IRIS {
	BLUE
}

enum PIERCING { # 1 Char has multiple of this # use `add_piercing` menthod to add piercing
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

enum BACK_HAIR {
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
	IS_SHORT_SHIRT,
	IS_SHORT_SHIRT_DESIGN,
}

enum LOWER_BODY_WEARABLE {
	IS_UNDERWEAR,
	IS_PANT,
	IS_PANTS_DESIGN,
	IS_SHORT,
	IS_SHORTS_DESIGN,
	IS_SKIRT
}

enum FRONT_HAIR {
	HAS_FRONTHAIR1,
	HAS_FRONTHAIR2,
	HAS_FRONTHAIR3,
	HAS_FRONTHAIR4,
}

enum ACCESSORIES { # 1 Char has multiple of this 
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

signal tags_updated
signal butt_size_changed
signal breast_size_changed
signal ovipositor_changed
signal anus_orifices_size_change
signal vagina_size_change
signal testicle_size_changed
signal penis_size_changed
signal penis_changed
signal back_hair_changed
signal front_hair_changed
signal pregbelly_changed
signal bulge_changed

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
	set(val): 
		penis = set_penis(val)
		penis_changed.emit()
@export var penis_size: PENIS_SIZE :
	get: return penis_size
	set(val): 
		penis_size = set_penis_size(val)
		penis_size_changed.emit()
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
	set(val): 
		pregbelly = set_pregbelly(val)
		pregbelly_changed.emit()
@export var age: AGE
@export var skin_color: SKIN_COLOR
@export var back_hair: BACK_HAIR:
	get: return back_hair
	set(val):
		back_hair = val
		back_hair_changed.emit()
@export var front_hair: FRONT_HAIR:
	get: return front_hair
	set(val):
		front_hair = val
		front_hair_changed.emit()
@export var piercing: QArray = QArray.new()
@export var upper_body_wearable: QArray = QArray.new()
@export var lower_body_wearable: QArray = QArray.new()
@export var accessories: QArray = QArray.new()
@export var makeup: QArray = QArray.new()
@export var has_bulge: bool :
	get: return has_bulge
	set(val): 
		has_bulge = false if gender == GENDER.FEMALE else val # dependent on Penis size
		bulge_changed.emit()

func _init():
	super()
#	stats_genrated.connect(add_tags)
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
	Age: {age}
	Skin color: {skin_color}
	Back Hair: {back_hair}
	Front hair: {front_hair}
	Piercing: {piercing}
	Upper Body Wearable: {upper_body_wearable}
	Lower Body Wearable: {lower_body_wearable}
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

	"age": AGE.find_key(self.age),
	"piercing": piercing.qarray.map(func(x): return PIERCING.find_key(x)),
	"skin_color": SKIN_COLOR.find_key(self.skin_color),
	"back_hair": BACK_HAIR.find_key(self.back_hair),
	"front_hair": FRONT_HAIR.find_key(self.front_hair),
	"upper_body_wearable": upper_body_wearable.qarray.map(func(x): return UPPER_BODY_WEARABLE.find_key(x)),
	"lower_body_wearable": lower_body_wearable.qarray.map(func(x): return LOWER_BODY_WEARABLE.find_key(x)),
	"accessories":  accessories.qarray.map(func(x): return ACCESSORIES.find_key(x)),
	"makeup": makeup.qarray.map(func(x): return MAKEUP.find_key(x)),
	"has_bulge": self.has_bulge,
})

func add_tags():
	self.butt_size = randi_range(BUTT_SIZE.IS_BUTT_SIZE1, BUTT_SIZE.IS_BUTT_SIZE3)
	self.breast_size = randi_range(BREAST_SIZE.IS_BREAST_SIZE0, BREAST_SIZE.IS_BREAST_SIZE5)
	self.penis = PENIS.HAS_CANINE_PENIS
	self.penis_size = randi_range(PENIS_SIZE.HAS_SOFT_PENIS_SIZE1, PENIS_SIZE.HAS_SOFT_PENIS_SIZE4)
	self.vagina = VAGINA.HAS_VAGINAL_ORIFICE_SIZE0
	self.ovipositor = OVIPOSITOR.HAS_OVIPOSITOR_SIZE0
	self.testicle_size = randi_range(TESTICLE_SIZE.HAS_TESTICLE_SIZE0,TESTICLE_SIZE.HAS_TESTICLE_SIZE4)
	self.anus_orifices = ANUS_ORIFICES.HAS_ANUS_ORIFICES_SIZE1
	self.pregbelly = randi_range(PREGBELLY.HAS_PREGBELLY_SIZE1, PREGBELLY.HAS_PREGBELLY_SIZE5) if pregnancy else PREGBELLY.HAS_PREGBELLY_SIZE0

	self.age = randi_range(AGE.IS_YOUNGADULT, AGE.IS_OLDADULT)
	self.skin_color = randi_range(SKIN_COLOR.HAS_PALESKIN, SKIN_COLOR.HAS_PALESKIN)
	self.back_hair = BACK_HAIR.values().pick_random()
	self.front_hair = randi_range(FRONT_HAIR.HAS_FRONTHAIR1, FRONT_HAIR.HAS_FRONTHAIR4)
	self.upper_body_wearable.append([UPPER_BODY_WEARABLE.IS_BRA,UPPER_BODY_WEARABLE.IS_SHORT_SLEEVE_SHIRT])#UPPER_BODY_WEARABLE.values().pick_random()
	self.lower_body_wearable.append([LOWER_BODY_WEARABLE.IS_UNDERWEAR,LOWER_BODY_WEARABLE.IS_PANT])# = LOWER_BODY_WEARABLE.IS_SKIRT#LOWER_BODY_WEARABLE.values().pick_random()
	self.has_bulge = false
	tags_updated.emit()

# Set Tags functions
func add_piercing(pie: PIERCING):
	match pie:
		PIERCING.IS_VAGINAL_PIERCED:
			if not gender == GENDER.MALE:
				self.piercing.add(pie)
		PIERCING.IS_PENIS_PIERCED:
			if not gender == GENDER.FEMALE:
				self.piercing.add(pie)
		PIERCING.IS_OVIPOSITOR_PIERCED:
			if race == RACE.MOTHKIN and gender == GENDER.FEMALE:
				self.piercing.add(pie)
		PIERCING.IS_HUMANEARSPIERCEDCOLORRED:
			if not race == RACE.FOXKIN:
				self.piercing.add(pie)
		PIERCING.IS_HALFFOXKINEARSPIERCED1, PIERCING.IS_HALFFOXKINEARSPIERCED2:
			if race == RACE.HALFFOXKIN:
				self.piercing.add(pie)
		PIERCING.IS_FOXKINEARSPIERCED1, PIERCING.IS_FOXKINEARSPIERCED2:
			if race == RACE.FOXKIN:
				self.piercing.add(pie)
		PIERCING.IS_MOTHKINANTENNARINGS:
			if race == RACE.MOTHKIN:
				self.piercing.add(pie)
		_:
			self.piercing.add(pie)

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


# Signals functions.

