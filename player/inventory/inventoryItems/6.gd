extends Resource

var name = "Simple Skirt"
var type = "Clothing"
var value = 25
var description = "A pink skirt that adds +2 to agility and +3 to role reputation."
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
	res.lower_body_wearable.add(CharacterTag.LOWER_BODY_WEARABLE.IS_SKIRT)
	res.agility += 2
	res.role_reputation += 3
	current_quantity -= 1
	is_equiped[res] = true

func when_unequiped(res: CharacterMod):
	if not is_equiped.has(res):
		return
	res.lower_body_wearable.remove(CharacterTag.LOWER_BODY_WEARABLE.IS_SKIRT)
	res.agility -= 2
	res.role_reputation -= 3
	current_quantity += 1
	is_equiped.erase(res)
