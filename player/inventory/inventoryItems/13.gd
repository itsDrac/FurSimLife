extends Resource

var name = "Simple Bra"
var type = "Clothing"
var value = 6
var description = "A bra made of simple material that adds +1 to role reputation"
const max_quantity = 2
@export var current_quantity := 2 :
	get: return current_quantity
	set(val): 
		current_quantity = val if val <= max_quantity else current_quantity
		current_quantity_updated.emit()

@export var is_equiped :Dictionary

signal current_quantity_updated

func when_equiped(res: CharacterMod):
	if current_quantity < 1:
		return
	if is_equiped.has(res):
		return
	res.upper_body_wearable.add(CharacterTag.UPPER_BODY_WEARABLE.IS_BRA)
	res.role_reputation += 1
	current_quantity -= 1
	is_equiped[res] = true
#	char.equiped_items.append(InventoryItem.ITEMS.Long_Sleeve_Shirt)

func when_unequiped(res: CharacterMod):
	if not is_equiped.has(res):
		return
	res.upper_body_wearable.remove(CharacterTag.UPPER_BODY_WEARABLE.IS_BRA)
	res.role_reputation -= 1
	current_quantity += 1
	is_equiped.erase(res)
