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

signal type_changed (t)
signal gender_changed (g)
signal role_changed (r)

@export var name: StringName
@export var type: TYPES:
	get: return type
	set(val):
		emit_signal("type_changed", val)
		type = val
@export var gender: GENDERS : 
	get: return gender
	set(val):
		emit_signal("gender_changed", val)
		gender = val
@export var role: ROLES : 
	get: return role
	set(val):
		emit_signal("role_changed", val)
		role = val
@export var health: int :
	get:
		return health
	set(val):
		health = clamp(val, 0, 100)
@export var attack : int :
	get: return attack
	set(val):
		attack = clamp(val, 0, 5)
@export var strength : int :
	get: return strength
	set(val):
		strength = clamp(val, 0, 5)
@export var defense : int :
	get: return defense
	set(val):
		defense = clamp(val, 0, 5)
@export var agility : int :
	get: return agility
	set(val):
		agility = clamp(val, 0, 5)
@export var intelligence : int :
	get: return intelligence
	set(val):
		intelligence = clamp(val, 0, 5)
@export var magic_power : int :
	get: return magic_power
	set(val):
		magic_power = clamp(val, 0, 5)
@export var role_reputation: int :
	get: return role_reputation
	set(val):
		role_reputation = clamp(val, 0, 100)

var fertility: float
var virility: float
var pregnancy: bool :
	get: return pregnancy
	set(val): pregnancy = _set_pregnancy(val)
var relationship_with_player: int
var egges
var egges_in_vagina
var egges_in_ass
var children
var monster_children

# have to add emit_changed in set function of all variables

func _to_string():
	return 
	"CharacterStats {
		Name: {name}
		Type: {type}
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
		
	}".format({
		"name": self.name,
		"type": TYPES.find_key(self.type),
		"gender": GENDERS.find_key(self.gender),
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
	})

func _init():
	print("printing from chracter stats")

static func _set_pregnancy(val):

# Sets random states to passed CharacterStats (`res`) object
static func genrate_stats(res: CharacterStats, _name: StringName, _type: TYPES = TYPES.NPC):
	res.name = _name
	res.type = _type
	res.gender = randi_range(GENDERS.FEMALE, GENDERS.MALE+1)
	res.role = randi_range(ROLES.MONARCHY,ROLES.NUN+1)
	res.health = randi_range(0, 101)
	res.attack = randi_range(0, 6)
	res.strength = randi_range(0, 6)
	res.defense = randi_range(0, 6)
	res.agility = randi_range(0, 6)
	res.intelligence = randi_range(0, 6)
	res.magic_power = randi_range(0, 6)
	res.role_reputation = randi_range(0, 101)
	res.fertility
	res.virility
	res.pregnancy
	res.relationship_with_player = randi_range(0,101) if res.type == TYPES.NPC else 0 
	res.egges
	res.egges_in_vagina
	res.children
	res.monster_children
	
