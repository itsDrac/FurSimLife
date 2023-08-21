extends Resource

var name = "Ancient Necklace"
var type = "Accessory"
var value = 300
var description = "An old Necklace with a blue gem that adds +5 to magic power and +3 to intelligence."
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
	char.res.piercing.add(CharacterTag.ACCESSORIES.HAS_NECKLACE)
	char.res.magic_power += 5
	char.res.intelligence += 3
	current_quantity -= 1
	is_equiped[char] = true

func when_unequiped(char: Character):
	if not is_equiped.has(char):
		return
	char.res.piercing.remove(CharacterTag.ACCESSORIES.HAS_NECKLACE)
	char.res.magic_power -= 5
	char.res.intelligence -= 3
	current_quantity += 1
	is_equiped.erase(char)
