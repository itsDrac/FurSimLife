extends Resource

var name = "Simple Bracelet"
var type = "Accessory"
var value = 30
var description = "A simple bracelet that adds +3 to attack and +1 to strength."
const max_quantity = 1
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
	res.piercing.add(CharacterTag.ACCESSORIES.HAS_BRACELET1)
	res.attack += 3
	res.strength += 1
	current_quantity -= 1
	is_equiped[res] = true

func when_unequiped(res: CharacterMod):
	if not is_equiped.has(res):
		return
	res.piercing.remove(CharacterTag.ACCESSORIES.HAS_BRACELET1)
	res.attack -= 3
	res.strength -= 1
	current_quantity += 1
	is_equiped.erase(res)
