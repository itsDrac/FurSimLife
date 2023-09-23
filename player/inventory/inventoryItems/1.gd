extends Resource

@export var name = "Long Sleeve Shirt"
@export var type = "Clothing"
@export var value = 20
@export var description = "A purple comfy Long Sleeve Shirt that adds +2 to defense and +2 to role reputation."
const max_quantity = 1

## Update current quantity to val less than Max quantity
@export var current_quantity := 0 :
	get: return current_quantity
	set(val): 
		current_quantity = val if val <= max_quantity else current_quantity
		current_quantity_updated.emit()

@export var is_equiped :Dictionary

signal current_quantity_updated

func when_equiped(res: CharacterMod):
	if is_equiped:
		return
	res.upper_body_wearable.add(CharacterTag.UPPER_BODY_WEARABLE.IS_LONG_SLEEVE_SHIRT)
	res.defense += 2
	res.role_reputation += 2
	current_quantity -= 1
	is_equiped[res] = true

func when_unequiped(res: CharacterMod):
	if not is_equiped.has(res):
		return
	res.upper_body_wearable.remove(CharacterTag.UPPER_BODY_WEARABLE.IS_LONG_SLEEVE_SHIRT)
	res.defense -= 2
	res.role_reputation -= 2
	current_quantity += 1
	is_equiped.erase(res)
