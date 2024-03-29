extends Resource

var name = "Ear Ring"
var type = "Piercing"
var value = 120
var description = "A golden ear ring that adds +2 to magic power and +4 to intelligence."
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
	res.piercing.add(CharacterTag.PIERCING.IS_FOXKINEARSPIERCED1)
	res.magic_power += 2
	res.intelligence += 4
	current_quantity -= 1
	is_equiped[res] = true

func when_unequiped(res: CharacterMod):
	if not is_equiped.has(res):
		return
	res.piercing.remove(CharacterTag.PIERCING.IS_FOXKINEARSPIERCED1)
	res.magic_power -= 2
	res.intelligence -= 4
	current_quantity += 1
	is_equiped.erase(res)
