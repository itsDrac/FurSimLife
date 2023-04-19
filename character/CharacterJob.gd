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
	HEROINE,
	SAINT,
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

static func assign_job(res: CharacterStats):
	match res.role:
		
		CharacterStats.ROLES.MONARCHY:
			if res.gender == CharacterTag.GENDER.IS_MALE:
				return [MONARCHY.KING,MONARCHY.HEIR_PRINCE,MONARCHY.PRINCE].pick_random()
			else :
				return [MONARCHY.QUEEN, MONARCHY.HEIR_PRINCESS,MONARCHY.PRINCESS].pick_random()
		CharacterStats.ROLES.BARNO:
			if res.gender == CharacterTag.GENDER.IS_MALE:
				return [BARNO.BARON, BARNO.FALLEN_BARON, BARNO.HEIR_SON_OF_BARON, BARNO.HEIR_DAUGHTER_OF_BARON, BARNO.SON_OF_BARON, BARNO.DAUGHTER_OF_BARON].pick_random()
			else :
				return [BARNO.BARONESS, BARNO.FALLEN_BARONESS, BARNO.HEIR_SON_OF_BARONESS, BARNO.HEIR_DAUGHTER_OF_BARONESS, BARNO.SON_OF_BARONESS, BARNO.DAUGHTER_OF_BARONESS].pick_random()
		CharacterStats.ROLES.MAID:
			if not res.gender == CharacterTag.GENDER.IS_MALE:
				return MAID.values().pick_random()
		CharacterStats.ROLES.MERCHANT:
			return MERCHANT.values().pick_random()
		CharacterStats.ROLES.VILLAGER:
			return VILLAGER.values().pick_random()
		CharacterStats.ROLES.ADVENTUER:
			return ADVENTUER.values().pick_random()
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
			return NUN.values().pick_random()

static func get_job_name(res):
	match res.role:
		
		CharacterStats.ROLES.MONARCHY:
			return MONARCHY.find_key(res.job)
		CharacterStats.ROLES.BARNO:
			return BARNO.find_key(res.job)
		CharacterStats.ROLES.MAID:
			return BARNO.find_key(res.job)
		CharacterStats.ROLES.MERCHANT:
			return MERCHANT.find_key(res.job)
		CharacterStats.ROLES.VILLAGER:
			return VILLAGER.find_key(res.job)
		CharacterStats.ROLES.ADVENTUER:
			return ADVENTUER.find_key(res.job)
		CharacterStats.ROLES.TOWN_GUARD:
			return TOWN_GUARD.find_key(res.job)
		CharacterStats.ROLES.ACADEMY_STUDENT:
			return ACADEMY_STUDENT.find_key(res.job)
		CharacterStats.ROLES.ACADEMY_PROFESSOR:
			return ACADEMY_PROFESSOR.find_key(res.job)
		CharacterStats.ROLES.CRIMINAL:
			return CRIMINAL.find_key(res.job)
		CharacterStats.ROLES.MAGE:
			return MAGE.find_key(res.job)
		CharacterStats.ROLES.KNIGHT:
			return KNIGHT.find_key(res.job)
		CharacterStats.ROLES.NUN:
			return NUN.find_key(res.job)
