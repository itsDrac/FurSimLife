extends Resource

var name = "Vaginal Piercing Example"
var type = "Piercing"
var value = 130
var description = "A golden piercing that adds +5 to fertility and +3 to role reputation."
const max_quantity = 1
var current_quantity := 0 :
	get: return current_quantity
	set(val): 
		current_quantity = val if val <= max_quantity else current_quantity
		current_quantity_updated.emit()

var is_equiped :Dictionary

signal current_quantity_updated

func when_equiped(char: Character):
	if char.res.gender == CharacterStats.GENDER.MALE:
		return
	if is_equiped:
		return
	char.res.piercing.add(CharacterTag.PIERCING.IS_VAGINAL_PIERCED)
	char.res.fertility += 5
	char.res.role_reputation += 3
	current_quantity -= 1
	is_equiped[char] = true

func when_unequiped(char: Character):
	if not is_equiped.has(char):
		return
	char.res.piercing.remove(CharacterTag.PIERCING.IS_VAGINAL_PIERCED)
	char.res.fertility -= 5
	char.res.role_reputation -= 3
	current_quantity += 1
	is_equiped.erase(char)
