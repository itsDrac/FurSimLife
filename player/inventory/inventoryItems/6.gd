extends Resource

var name = "Simple Skirt"
var type = "Clothing"
var value = 25
var description = "A pink skirt that adds +2 to agility and +3 to role reputation."
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
	char.res.upper_body_wearable.add(CharacterTag.LOWER_BODY_WEARABLE.IS_SKIRT)
	char.res.agility += 2
	char.res.role_reputation += 3
	current_quantity -= 1
	is_equiped[char] = true
#	char.equiped_items.append(InventoryItem.ITEMS.Long_Sleeve_Shirt)

func when_unequiped(char: Character):
	if not is_equiped.has(char):
		return
	char.res.upper_body_wearable.remove(CharacterTag.LOWER_BODY_WEARABLE.IS_SKIRT)
	char.res.agility -= 2
	char.res.role_reputation -= 3
	current_quantity += 1
	is_equiped.erase(char)
