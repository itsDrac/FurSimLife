extends Resource

var name = "Poorly Made Staff"
var type = "Weapon"
var value = 5
var description = "A poorly made staff that adds +1 to magic power."
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
	res.magic_power += 1
	current_quantity -= 1
	is_equiped[res] = true

func when_unequiped(res: CharacterMod):
	if not is_equiped.has(res):
		return
	res.magic_power -= 1
	current_quantity += 1
	is_equiped.erase(res)
