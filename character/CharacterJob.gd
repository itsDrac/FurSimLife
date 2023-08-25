extends Resource
class_name CharacterJob

enum MONARCHY {
	KING,
	QUEEN,
	PRINCE,
	PRINCESS,
	HEIR_PRINCE,
	HEIR_PRINCESS

}
enum BARNO {
	BARON,
	BARONESS,
	FALLEN_BARON,
	FALLEN_BARONESS,
	HEIR_SON_OF_BARON,
	HEIR_SON_OF_BARONESS,
	HEIR_DAUGHTER_OF_BARON,
	HEIR_DAUGHTER_OF_BARONESS,
	SON_OF_BARON,
	SON_OF_BARONESS,
	DAUGHTER_OF_BARON,
	DAUGHTER_OF_BARONESS

}
enum MAID {
	ROYAL_MAID,
	NOBLEMANS_MAID,
	NOBLEWOMANS_MAID,
	WARRIOR_MAID,
	MAID_OF_HEIR,
	TOWN_MAID

}
enum MERCHANT {
	Traveling_Merchant,
	Village_Merchant,
	City_Merchant,
	Town_Merchant,
	Armory_Merchant,
	Item_Merchant

}
enum VILLAGER {
	BEGGAR,
	FARMER,
	WOODCUTTER,
	MINER

}
enum ADVENTUER {
	KNIGHT,
	MAGE,
	ARCHER,
	HEALER,
	HERO,
	SAINT,
	HEROINE,
	SAINTESS

}
enum TOWN_GUARD {
	GUARD,
	MERCHANT_GUARD,
	DUNGEON_ENTRANCE_GUARD,
	CRIMINAL,
	THIEF,
	BANDIT,
	RAIDER

}

enum CRIMINAL {
	THIEF,
	BANDIT,
	RAIDER,
}

enum ACADEMY_STUDENT {
	NORMAL_CLASS_STUDENT,
	HIGH_CLASS_STUDENT,
	LOW_CLASS_STUDENT

}
enum ACADEMY_PROFESSOR {
	MAGIC_PROFESSOR,
	KNIGHT_PROFESSOR,
	ALCHEMY_PROFESSOR

}
enum MAGE {
	TOWN_MAGE,
	CITY_MAGE,
	ROYAL_MAGE,
	NOBLE_MAGE,
	MASTER_MAGE,
	GRANDMASTER_MAGE

}
enum KNIGHT {
	TOWN_KNIGHT,
	CITY_KNIGHT,
	ROYAL_KNIGHT,
	NOBLE_KNIGHT,
	KNIGHT_CAPTAIN,
	KNIGHT_GENERAL

}
enum NUN {
	PRIEST,
	NUN
}

var res: CharacterStats
var job
func setup_res(stats:CharacterStats):
	self.res=stats
	res.role_changed.connect(update_job)

func update_job():
	job = assign_job()

func assign_job():
	match res.role:
		
		CharacterStats.ROLES.MONARCHY:
			if res.gender == CharacterStats.GENDER.MALE:
				return [MONARCHY.KING,MONARCHY.HEIR_PRINCE,MONARCHY.PRINCE].pick_random()
			else :
				return [MONARCHY.QUEEN, MONARCHY.HEIR_PRINCESS,MONARCHY.PRINCESS].pick_random()
		CharacterStats.ROLES.BARNO:
			if res.gender == CharacterStats.GENDER.MALE:
				# Baron, Fallen Baron, Son of Baron(heir), Son of Baroness(heir), Son of Baron, Son of Baroness
				return [BARNO.BARON, BARNO.FALLEN_BARON, BARNO.HEIR_SON_OF_BARON, BARNO.SON_OF_BARON, BARNO.SON_OF_BARONESS].pick_random()
			else :
				#  Baroness, Fallen Baroness, Daughter of Baron(heir), Daughter of Baroness(heir), Daughter of Baron, Daughter of Baroness,
				return [BARNO.BARONESS, BARNO.FALLEN_BARONESS, BARNO.HEIR_DAUGHTER_OF_BARON, BARNO.HEIR_DAUGHTER_OF_BARONESS, BARNO.DAUGHTER_OF_BARON, BARNO.DAUGHTER_OF_BARONESS].pick_random()
		CharacterStats.ROLES.MAID:
			if not res.gender == CharacterStats.GENDER.MALE:
				return MAID.values().pick_random()
		CharacterStats.ROLES.MERCHANT:
			return MERCHANT.values().pick_random()
		CharacterStats.ROLES.VILLAGER:
			return VILLAGER.values().pick_random()
		CharacterStats.ROLES.ADVENTUER:
			if res.gender == CharacterStats.GENDER.MALE:
				return randi_range(ADVENTUER.KNIGHT, ADVENTUER.SAINT)
			else:
				return [ADVENTUER.ARCHER, ADVENTUER.HEALER, ADVENTUER.HEROINE, ADVENTUER.KNIGHT, ADVENTUER.MAGE, ADVENTUER.SAINTESS].pick_random()
		CharacterStats.ROLES.TOWN_GUARD:
			return TOWN_GUARD.values().pick_random()
		CharacterStats.ROLES.CRIMINAL:
			return CRIMINAL.values().pick_random()
		CharacterStats.ROLES.ACADEMY_STUDENT:
			return ACADEMY_STUDENT.values().pick_random()
		CharacterStats.ROLES.ACADEMY_PROFESSOR:
			return ACADEMY_PROFESSOR.values().pick_random()
		CharacterStats.ROLES.MAGE:
			return MAGE.values().pick_random()
		CharacterStats.ROLES.KNIGHT:
			return KNIGHT.values().pick_random()
		CharacterStats.ROLES.NUN:
			if res.gender == CharacterStats.GENDER.MALE:
				return NUN.PRIEST
			else:
				return NUN.NUN

func get_job_name() -> StringName:
	match res.role:
		
		CharacterStats.ROLES.MONARCHY:
			return MONARCHY.find_key(job)
		CharacterStats.ROLES.BARNO:
			return BARNO.find_key(job)
		CharacterStats.ROLES.MAID:
			return MAID.find_key(job)
		CharacterStats.ROLES.MERCHANT:
			return MERCHANT.find_key(job)
		CharacterStats.ROLES.VILLAGER:
			return VILLAGER.find_key(job)
		CharacterStats.ROLES.ADVENTUER:
			return ADVENTUER.find_key(job)
		CharacterStats.ROLES.TOWN_GUARD:
			return TOWN_GUARD.find_key(job)
		CharacterStats.ROLES.ACADEMY_STUDENT:
			return ACADEMY_STUDENT.find_key(job)
		CharacterStats.ROLES.ACADEMY_PROFESSOR:
			return ACADEMY_PROFESSOR.find_key(job)
		CharacterStats.ROLES.CRIMINAL:
			return CRIMINAL.find_key(job)
		CharacterStats.ROLES.MAGE:
			return MAGE.find_key(job)
		CharacterStats.ROLES.KNIGHT:
			return KNIGHT.find_key(job)
		CharacterStats.ROLES.NUN:
			return NUN.find_key(job)
		_:
			return "Not_Found"
