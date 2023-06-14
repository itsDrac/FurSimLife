extends Resource

class_name CharacterStats

enum VIEW {
	FRONT,
	SIDE,
	BACK
}

enum TYPES {
	PLAYER,
	NPC
}

enum RACE {
	HUMAN,
	FOXKIN,
	HALFFOXKIN,
	MOTHKIN,
}

enum GENDER {
	FEMALE=0,
	FUTA=3,
	MALE=6
}

enum ROLES {
	MONARCHY,
	BARNO,
	MAID,
	MERCHANT,
	VILLAGER,
	ADVENTUER,
	TOWN_GUARD,
	CRIMINAL,
	ACADEMY_STUDENT,
	ACADEMY_PROFESSOR,
	MAGE,
	KNIGHT,
	NUN 
}

enum NOTI {
	PREGNANCY_CHANGED = 0
}


signal view_changed
signal type_changed (t)
signal gender_changed (g)
signal role_changed
signal pregnancy_changed
signal stats_genrated

@export_category("Character Stats")
@export var view: VIEW :
	get: return view
	set(val):
		view = val
		view_changed.emit()
@export var name: StringName
@export var type: TYPES :
	get: return type
	set(val):
		emit_signal("type_changed", val)
		type = val
@export var race : RACE
@export var gender: GENDER : 
	get: return gender
	set(val): gender = GENDER.FEMALE if race == RACE.MOTHKIN else val
@export var role: ROLES : 
	get: return role
	set(val):
		role = val
		role_changed.emit()
@export var health: int
@export var attack: int :
	get: return attack
	set(val):
		attack = clamp(val, 0, 99)
@export var strength: int :
	get: return strength
	set(val):
		strength = clamp(val, 0, 99)
@export var defense: int :
	get: return defense
	set(val):
		defense = clamp(val, 0, 99)
@export var agility: int :
	get: return agility
	set(val):
		agility = clamp(val, 0, 99)
@export var intelligence: int :
	get: return intelligence
	set(val):
		intelligence = clamp(val, 0, 99)
@export var magic_power: int :
	get: return magic_power
	set(val):
		magic_power = clamp(val, 0, 99)
@export var role_reputation: int :
	get: return role_reputation
	set(val):
		role_reputation = clamp(val, 0, 100)
@export var fertility: float :
	get: return fertility
	set(val): fertility = val if not gender == GENDER.MALE else 0.0 
@export var virility: float :
	get: return virility
	set(val): virility = val if gender == GENDER.FEMALE else 0.0 
@export var pregnancy: bool :
	get: return pregnancy
	set(val): 
		pregnancy = val if not gender == GENDER.MALE else false
		pregnancy_changed.emit()
@export var pregnancy_duration: int :
	get: return pregnancy_duration
	set(val): pregnancy_duration = clamp(val,0,30) if pregnancy else 0
@export var relationship_with_player: int :
	get: return relationship_with_player
	set(val): relationship_with_player = clamp(val,0,200) if type == TYPES.NPC else 0
@export var depositable_eggs: int :
	get: return depositable_eggs
	set(val): depositable_eggs = val if self.race == RACE.MOTHKIN else 0
@export var eggs_duration: int
@export var eggs_in_vagina: int
@export var eggs_in_vagina_duration: int
@export var eggs_in_ass: int
@export var eggs_in_ass_duration: int
@export var children: int
@export var monster_children: int
@export var job: CharacterJob = CharacterJob.new()
# have to add emit_changed in set function of all variables

func _to_string():
	return "CharacterStats {
	Name: {name}
	Type: {type}
	Race {race}
	Gender: {gender}
	Role: {role}
	Health: {health}
	Attack: {attack}
	Strength: {strength}
	Defense: {defense}
	Agility: {agility}
	Intelligence: {intelligence}
	Magic power: {magic_power}
	Role reputation: {role_reputation}
	Fertility: {fertility}
	Virility: {virility}
	Pregnancy: {pregnancy}
	Pregnancy duration: {pregnancy_duration}
	Relationship with player: {rwp}
	Depositable Eggs: {depositable_eggs}
	Eggs duration {eggs_duration}
	Eggs in vagina {eiv}
	Eggs in ass {eia}
	Eggs in vagina duration {eivd}
	Eggs in ass duration {eiad}
	Children: {children}
	Monster children: {mchildren}
	Job: {job}
}".format({
	"name": self.name,
	"type": TYPES.find_key(self.type),
	"gender": GENDER.find_key(self.gender),
	"race": RACE.find_key(self.race),
	"role": ROLES.find_key(self.role),
	"health": self.health,
	"attack": self.attack,
	"strength": self.strength,
	"defense": self.defense,
	"agility": self.agility,
	"intelligence": self.intelligence,
	"magic_power": self.magic_power,
	"role_reputation": self.role_reputation,
	"fertility": self.fertility,
	"virility": self.virility,
	"pregnancy": self.pregnancy,
	"pregnancy_duration": self.pregnancy_duration,
	"rwp": self.relationship_with_player,
	"depositable_eggs": self.depositable_eggs,
	"eggs_duration": self.eggs_duration,
	"eiv": self.eggs_in_vagina,
	"eia": self.eggs_in_ass,
	"eivd": self.eggs_in_vagina_duration,
	"eiad": self.eggs_in_ass_duration,
	"children": self.children,
	"mchildren": self.monster_children,
	"job":job.get_job_name(),
})

# Sets random states to passed CharacterStats (`res`) object
func genrate_stats(_name: StringName, _type: TYPES = TYPES.NPC):
	name = _name
	type = _type
	view = VIEW.FRONT
	race = RACE.MOTHKIN#randi_range(RACE.HUMAN, RACE.MOTHKIN)
	gender = GENDER.FEMALE#randi_range(GENDER.FEMALE, GENDER.MALE)
	role = randi_range(ROLES.MONARCHY,ROLES.NUN if gender == GENDER.FEMALE else ROLES.KNIGHT)
	health = randi_range(45, 100) if type == TYPES.NPC else 100
	attack = randi_range(1, 5)
	strength = randi_range(0, 5)
	defense = randi_range(0, 5)
	agility = randi_range(0, 5)
	intelligence = randi_range(0, 5)
	magic_power = randi_range(1, 5)
	role_reputation = randi_range(0, 90)
	fertility = float("%.2f"%randf())
	virility = float("%.2f"%randf())
	pregnancy = false
	pregnancy_duration = 0
	relationship_with_player = 40
	depositable_eggs = randi_range(0,5)
	eggs_duration = 0
	eggs_in_vagina = 0
	eggs_in_vagina_duration = 0
	eggs_in_ass = 0
	eggs_in_ass_duration = 0
	children = 0
	monster_children = 0
	job.setup_res(self)
	job.update_job()
	stats_genrated.emit()

func set_role(val):
	if val == ROLES.MAID:
		if gender == GENDER.MALE:
			return ROLES.values().pick_random()
	return val
