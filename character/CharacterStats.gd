extends Resource

class_name CharacterStats
enum TYPES {
	PLAYER,
	NPC
}
enum GENDERS {
	FEMALE,
	FUTA,
	MALE
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

enum RACE {
	HUMAN,
	FOXKIN,
	HALFFOXKIN,
	MOTHKIN
}

signal type_changed (t)
signal gender_changed (g)
signal role_changed (r)

@export var name: StringName
@export var type: TYPES :
	get: return type
	set(val):
		emit_signal("type_changed", val)
		type = val
@export var gender: GENDERS : 
	get: return gender
	set(val):
		emit_signal("gender_changed", val)
		gender = val
@export var race : RACE :
	get: return race
	set(val): val if not (val == RACE.MOTHKIN and gender == GENDERS.MALE) else RACE.HALFFOXKIN
@export var role: ROLES : 
	get: return role
	set(val):
		emit_signal("role_changed", val)
		role = val
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
	set(val): fertility = val if not gender == GENDERS.MALE else 0.0 
@export var virility: float :
	get: return virility
	set(val): virility = val if gender == GENDERS.FEMALE else 0.0 
@export var pregnancy: bool :
	get: return pregnancy
	set(val): pregnancy = val if not gender == GENDERS.MALE else false 
@export var pregnancy_duration: int :
	get: return pregnancy_duration
	set(val): pregnancy_duration = clamp(val,0,30) if pregnancy else 0
@export var relationship_with_player: int :
	get: return relationship_with_player
	set(val): relationship_with_player = clamp(val,0,200) if type == TYPES.NPC else 0
@export var eggs: int :
	get: return eggs
	set(val): eggs = val if self.race == RACE.MOTHKIN else 0
@export var eggs_duration: int
#@export var eggs_in_vagina: int
#@export var eggs_in_vagina_duration: int
#@export var eggs_in_ass: int
@export var children: int
@export var monster_children: int
@export var job: int
@export var tag: CharacterTag
# have to add emit_changed in set function of all variables

func _to_string():
	return "CharacterStats {
	Name: {name}
	Type: {type}
	Gender: {gender}
	Race {race}
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
	Eggs: {eggs}
	Eggs duration {eggs_duration}
	Children: {children}
	Monster children: {mchildren}
	Job: {job}
	Tag: {tag}
}".format({
	"name": self.name,
	"type": TYPES.find_key(self.type),
	"gender": GENDERS.find_key(self.gender),
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
	"eggs": self.eggs,
#	"eiv": self.eggs_in_vagina,
#	"eia": self.eggs_in_ass,
	"eggs_duration": self.eggs_duration,
	"children": self.children,
	"mchildren": self.monster_children,
	"job": CharacterJob.get_job_name(self),
	"tag": self.tag._to_string()
})

# Sets random states to passed CharacterStats (`res`) object
static func genrate_stats(res: CharacterStats, _name: StringName, _type: TYPES = TYPES.NPC):
	res.name = _name
	res.type = _type
	res.gender = randi_range(GENDERS.FEMALE, GENDERS.MALE)
	res.race = randi_range(RACE.HUMAN, RACE.MOTHKIN)
	res.role = randi_range(ROLES.MONARCHY,ROLES.NUN if res.gender == GENDERS.FEMALE else ROLES.KNIGHT)
	res.health = randi_range(45, 100) if res.type == TYPES.NPC else 100
	res.attack = randi_range(1, 5)
	res.strength = randi_range(0, 5)
	res.defense = randi_range(0, 5)
	res.agility = randi_range(0, 5)
	res.intelligence = randi_range(0, 5)
	res.magic_power = randi_range(1, 5)
	res.role_reputation = randi_range(0, 90)
	res.fertility = float("%.2f"%randf())
	res.virility = float("%.2f"%randf())
	res.pregnancy = false
	res.pregnancy_duration = 0
	res.relationship_with_player = 40
	res.eggs = randi_range(0,5)
	res.eggs_duration = 0
#	res.eggs_in_vagina = randi_range(0,5)
#	res.eggs_in_ass = randi_range(0,5)
	res.children = 0
	res.monster_children = 0
	res.job = CharacterJob.assign_job(res)
	res.tag = CharacterTag.new()
	res.tag.add_tags(res)
