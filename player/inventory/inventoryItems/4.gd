extends Resource

var name = "Vaginal Piercing Example"
var type = "Piercing"
var value = 130
var description = "A golden piercing that adds +5 to fertility and +3 to role reputation."
const max_quantity = 1
@export var current_quantity := 0 :
	get: return current_quantity
	set(val): 
		current_quantity = val if val <= max_quantity else current_quantity
		current_quantity_updated.emit()

@export var is_equiped :Dictionary

signal current_quantity_updated

func when_equiped(res: CharacterMod):
	if res.gender == CharacterStats.GENDER.MALE:
		return
	if is_equiped:
		return
	res.piercing.add(CharacterTag.PIERCING.IS_VAGINAL_PIERCED)
	res.fertility += 0.05
	res.role_reputation += 3
	current_quantity -= 1
	is_equiped[res] = true

func when_unequiped(res: CharacterMod):
	if not is_equiped.has(res):
		return
	res.piercing.remove(CharacterTag.PIERCING.IS_VAGINAL_PIERCED)
	res.fertility -= 0.05
	res.role_reputation -= 3
	current_quantity += 1
	is_equiped.erase(res)
