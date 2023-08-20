extends Resource

var name = "Long Sleeve Shirt"
var type = "Clothing"
var value = 20
var description = "A purple comfy Long Sleeve Shirt that adds +2 to defense and +2 to role reputation."
const max_quantity = 1
var current_quantity := 0 :
	get: return current_quantity
	set(val): 
		current_quantity = val if val <= max_quantity else current_quantity
		current_quantity_updated.emit()

var is_equiped :Dictionary

signal current_quantity_updated

func when_equiped(char: Character):
	if is_equiped:
		return
	char.res.upper_body_wearable.add(CharacterTag.UPPER_BODY_WEARABLE.IS_LONG_SLEEVE_SHIRT)
	char.res.defense += 2
	char.res.role_reputation += 2
	current_quantity -= 1
	is_equiped[char] = true
#	char.equiped_items.append(InventoryItem.ITEMS.Long_Sleeve_Shirt)

func when_unequiped(char: Character):
	if not is_equiped.has(char):
		return
	char.res.upper_body_wearable.remove(CharacterTag.UPPER_BODY_WEARABLE.IS_LONG_SLEEVE_SHIRT)
	char.res.defense -= 2
	char.res.role_reputation -= 2
	current_quantity += 1
	is_equiped.erase(char)
