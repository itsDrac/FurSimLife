extends Resource
class_name CharacterTag

enum GENDER {
	IS_FEMALE,
	IS_FUTA,
	IS_MALE
}

enum RACE {
	IS_HUMAN,
	IS_FOXKIN,
	IS_HALFFOXKIN,
	IS_MOTHKIN
}

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

enum GENITAL {
	Has_vagina,

	HAS_H_PENIS_SIZE1,
	HAS_H_PENIS_SIZE2,
	HAS_H_PENIS_SIZE3,
	HAS_H_PENIS_SIZE4,

	HAS_C_PENIS_SIZE1,
	HAS_C_PENIS_SIZE2,
	HAS_C_PENIS_SIZE3,
	HAS_C_PENIS_SIZE4,

	HAS_OVIPOSITOR_SIZE1,
	HAS_OVIPOSITOR_SIZE2,
	HAS_OVIPOSITOR_SIZE3,
	HAS_OVIPOSITOR_SIZE4,

	HAS_SOFT_PENIS,
	HAS_HARD_PENIS,
}

enum TESTICLE_SIZE {
	HAS_TESTICLE_SIZE0,
	HAS_TESTICLE_SIZE1,
	HAS_TESTICLE_SIZE2,
	HAS_TESTICLE_SIZE3,
	HAS_TESTICLE_SIZE4,
}

enum VAGINAL_ORIFICES {
	HAS_VAGINAL_ORIFICES_SIZE0,
	HAS_VAGINAL_ORIFICES_SIZE1,
	HAS_VAGINAL_ORIFICES_SIZE2,
	HAS_VAGINAL_ORIFICES_SIZE3,
}

enum ANUS_ORIFICES {
	HAS_ANUS_ORIFICES_SIZE0,
	HAS_ANUS_ORIFICES_SIZE1,
	HAS_ANUS_ORIFICES_SIZE2,
	HAS_ANUS_ORIFICES_SIZE3,
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
	IS_NIPPLE_PIERCED,
	IS_VAGINAL_PIERCED,
	IS_ANAL_PIERCED,
	IS_COCK_PIERCED,
	IS_OVIPOSITOR_PIERCED,
	IS_EYEBROW_PIERCED,
	IS_LIP_PIERCED,
	IS_NOSE_PIERCED,
}

@export var gender: GENDER
@export var race: RACE
@export var butt_size: BUTT_SIZE
@export var breast_size: BREAST_SIZE
@export var genital: GENITAL
@export var testicle_size: TESTICLE_SIZE
@export var vaginal_orifices: VAGINAL_ORIFICES
@export var anus_orifices: ANUS_ORIFICES
@export var pergbelly: PREGBELLY
@export var eggpregbelly: EGGPREGBELLY
@export var eggpregbelly_anal: EGGPREGBELLY_ANAL
@export var age: AGE
@export var piercing: PIERCING

func _to_string():
	return "CharacterTag {
		Gender: {gender}
		Race: {race}
		Butt size: {butt_size}
		Breast size: {breast_size}
		Genital: {genital}
		Testicle size: {testicle_size}
		Vaginal orifices: {vaginal_orifices}
		Anus orifices: {anus_orifices}
		Pergbelly: {pergbelly}
		Eggpregbelly: {eggpregbelly}
		Eggpregbelly anal: {eggpregbelly_anal}
		Age: {age}
		Piercing: {piercing}
	}".format({
	"gender": GENDER.find_key(self.gender),
	"race": RACE.find_key(self.race),
	"butt_size": BUTT_SIZE.find_key(self.butt_size),
	"breast_size": BREAST_SIZE.find_key(self.breast_size),
	"genital": GENITAL.find_key(self.genital),
	"testicle_size": TESTICLE_SIZE.find_key(self.testicle_size),
	"vaginal_orifices": VAGINAL_ORIFICES.find_key(self.vaginal_orifices),
	"anus_orifices": ANUS_ORIFICES.find_key(self.anus_orifices),
	"pergbelly": PREGBELLY.find_key(self.pergbelly),
	"eggpregbelly": EGGPREGBELLY.find_key(self.eggpregbelly),
	"eggpregbelly_anal": EGGPREGBELLY_ANAL.find_key(self.eggpregbelly_anal),
	"age": AGE.find_key(self.age),
	"piercing": PIERCING.find_key(self.piercing)
	})

func add_tags(res: CharacterStats):
	self.gender = GENDER.find_key(res.gender)
	self.race = RACE.find_key(res.race)
	self.butt_size = randi_range(BUTT_SIZE.IS_BUTT_SIZE1, BUTT_SIZE.IS_BUTT_SIZE3)
	self.breast_size = randi_range(BREAST_SIZE.IS_BREAST_SIZE0, BREAST_SIZE.IS_BREAST_SIZE5)
	self.genital = randi_range(GENITAL.Has_vagina,GENITAL.HAS_HARD_PENIS)
	self.testicle_size = randi_range(TESTICLE_SIZE.HAS_TESTICLE_SIZE0,TESTICLE_SIZE.HAS_TESTICLE_SIZE4)
	self.vaginal_orifices = randi_range(VAGINAL_ORIFICES.HAS_VAGINAL_ORIFICES_SIZE0,VAGINAL_ORIFICES.HAS_VAGINAL_ORIFICES_SIZE3)
	self.anus_orifices = randi_range(ANUS_ORIFICES.HAS_ANUS_ORIFICES_SIZE0,ANUS_ORIFICES.HAS_ANUS_ORIFICES_SIZE3)
	self.pergbelly = randi_range(PREGBELLY.HAS_PREGBELLY_SIZE0, PREGBELLY.HAS_PREGBELLY_SIZE5)
	self.eggpregbelly = randi_range(EGGPREGBELLY.HAS_EGGPREGBELLY_SIZE0, EGGPREGBELLY.HAS_EGGPREGBELLY_SIZE5)
	self.eggpregbelly_anal = randi_range(EGGPREGBELLY_ANAL.HAS_AEGGPREGBELLY_SIZE0, EGGPREGBELLY_ANAL.HAS_AEGGPREGBELLY_SIZE5)
	self.age = randi_range(AGE.IS_YOUNGADULT, AGE.IS_OLDADULT)
	self.piercing = randi_range(PIERCING.IS_NIPPLE_PIERCED, PIERCING.IS_NOSE_PIERCED)
