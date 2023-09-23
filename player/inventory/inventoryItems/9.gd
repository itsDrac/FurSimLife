extends Resource

var name = "Ancient Necklace"
var type = "Accessory"
var value = 300
var description = "An old Necklace with a blue gem that adds +5 to magic power and +3 to intelligence."
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
	res.piercing.add(CharacterTag.ACCESSORIES.HAS_NECKLACE)
	res.magic_power += 5
	res.intelligence += 3
	current_quantity -= 1
	is_equiped[res] = true

func when_unequiped(res: CharacterMod):
	if not is_equiped.has(res):
		return
	res.piercing.remove(CharacterTag.ACCESSORIES.HAS_NECKLACE)
	res.magic_power -= 5
	res.intelligence -= 3
	current_quantity += 1
	is_equiped.erase(res)
